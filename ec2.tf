###################################
## Virtual Machine Module - Main ##
###################################

# Create Elastic IP for the EC2 instance
resource "aws_eip" "ec2_eip" {
  count    = 1
  instance = aws_instance.ec2_instance[count.index].id
  vpc      = true
  tags = {
    Name        = "${lower(var.app_name)}-${var.app_environment}-linux-eip"
    Environment = var.app_environment
  }
}

# Define the security group for the Linux server
resource "aws_security_group" "ec2_sg" {
  name        = "${lower(var.app_name)}-${var.app_environment}-ec2-sg"
  description = "Allow incoming Instance connections"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow incoming HTTP connections"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow incoming HTTPS connections"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow incoming SSH connections"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${lower(var.app_name)}-${var.app_environment}-ec2-sg"
    Environment = var.app_environment
  }
}

# Create EC2 Instance
resource "aws_instance" "ec2_instance" {
  count                  = 1
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = var.linux_instance_type
  subnet_id              = aws_subnet.public_subnet[count.index].id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  key_name               = aws_key_pair.key_pair.key_name
  user_data              = file("ec2_script.sh")
  tags = {
    Name        = "${lower(var.app_name)}-${var.app_environment}-ec2_intance"
    Environment = var.app_environment
  }

}
/* 
resource "null_resource" "ec2_install_wordpress" {
  count = 1
  depends_on = [
    aws_instance.ec2_instance
  ]
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("${aws_key_pair.key_pair.key_name}.pem")
    host        = aws_eip.ec2_eip[count.index].public_ip
  }
  provisioner "remote-exec" {
    inline = [
      #"sudo yum update -y",
      "sudo yum install httpd wget zip -y",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",
      "cd /var/www/html",
      "sudo wget https://wordpress.org/wordpress-5.7.2.zip",
      "sudo unzip wordpress-5.7.2.zip",
      "sudo mv -f wordpress/* ./",
      "sudo rm -rf wordpress wordpress-5.7.2.zip",
    ]
  }

}

resource "null_resource" "ec2_config_wordpress" {
  count = 1
  depends_on = [
    null_resource.ec2_install_wordpress
  ]
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("${aws_key_pair.key_pair.key_name}.pem")
    host        = aws_eip.ec2_eip[count.index].public_ip

  }
  provisioner "remote-exec" {
    inline = [
      "sudo yum install -y amazon-linux-extras",
      "sudo amazon-linux-extras enable php7.2",
      "sudo yum clean metadata -y",
      "sudo yum install php-cli php-pdo php-fpm php-json php-mysqlnd -y",
      "sudo systemctl restart httpd"
    ]
  }

} */
