###################################
## Virtual Machine Module - Main ##
###################################

# Create Elastic IP for the EC2 instance
resource "aws_eip" "linux-eip" {
  vpc = true
  tags = {
    Name        = "${lower(var.app_name)}-${var.app_environment}-linux-eip"
    Environment = var.app_environment
  }
}

# Create EC2 Instance
resource "aws_instance" "ec2_wordpress" {
  ami                         = "ami-06640050dc3f556bb" #data.aws_ami.rhel_8_5.id #ami-06640050dc3f556bb (64-bit (x86)) Red Hat Enterprise Linux 8 (HVM), SSD Volume Type
  instance_type               = var.linux_instance_type
  subnet_id                   = aws_subnet.public-subnet.id
  vpc_security_group_ids      = [aws_security_group.aws-linux-sg.id]
  associate_public_ip_address = var.linux_associate_public_ip_address
  source_dest_check           = false
  key_name                    = aws_key_pair.key_pair.key_name
  #user_data                   = file("user-data.sh")

  # root disk
  root_block_device {
    volume_size           = var.linux_root_volume_size
    volume_type           = var.linux_root_volume_type
    delete_on_termination = true
    encrypted             = true
  }

  # extra disk
  ebs_block_device {
    device_name           = "/dev/xvda"
    volume_size           = var.linux_data_volume_size
    volume_type           = var.linux_data_volume_type
    encrypted             = true
    delete_on_termination = true
  }

  tags = {
    Name        = "${lower(var.app_name)}-${var.app_environment}-ec2_wordpress"
    Environment = var.app_environment
  }
}

# Associate Elastic IP to Linux Server
resource "aws_eip_association" "linux-eip-association" {
  instance_id   = aws_instance.ec2_wordpress.id
  allocation_id = aws_eip.linux-eip.id
}

# Define the security group for the Linux server
resource "aws_security_group" "aws-linux-sg" {
  name        = "${lower(var.app_name)}-${var.app_environment}-linux-sg"
  description = "Allow incoming HTTP connections"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow incoming HTTP connections"
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
    Name        = "${lower(var.app_name)}-${var.app_environment}-linux-sg"
    Environment = var.app_environment
  }
}

resource "null_resource" "ec2_install_wordpress" {
  depends_on = [
    aws_instance.ec2_wordpress
  ]
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("${aws_key_pair.key_pair.key_name}.pem")
    host        = aws_eip.linux-eip.public_ip
  }
  provisioner "remote-exec" {
    inline = [
      #"sudo yum update -y",
      "sudo yum install httpd wget zip -y",
      "sudo yum install wget -y",
      "sudo yum install zip -y",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",
      "cd /var/www/html",
      "sudo wget https://wordpress.org/wordpress-5.7.2.zip",
      "sudo unzip -xzf wordpress-5.7.2.zip",
    ]
  }

}

resource "null_resource" "ec2_config_wordpress" {
  depends_on = [
    null_resource.ec2_install_wordpress
  ]
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("${aws_key_pair.key_pair.key_name}.pem")
    host        = aws_eip.linux-eip.public_ip

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

}
