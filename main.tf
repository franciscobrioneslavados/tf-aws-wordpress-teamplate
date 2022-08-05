resource "aws_security_group" "sg_wordpress" {
  name = "security_group_wordpress"
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow http"
    from_port   = 0
    to_port     = 80
    protocol    = "tcp"
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "permit all"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }

}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("id_rsa.pub")
}

resource "aws_instance" "ec2_wordpress" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.deployer.key_name
  security_groups = ["security_group_wordpress"]
  tags = {
    app  = "tf_wordpress"
    role = "wordpress-frontend"
  }
}

resource "aws_eip" "eip_wordpress" {
  instance = aws_instance.ec2_wordpress.id
  vpc      = true
  tags = {
    app = "tf_eip_wordpress"
  }
}

resource "aws_db_instance" "db_wordpress" {
  
  instance_class      = "db.t3.micro"
  engine              = "mysql"
  publicly_accessible = false
  allocated_storage   = 20
  name                = var.db_name
  username            = var.db_username
  password            = var.db_password
  skip_final_snapshot = true
  tags = {
    app = "tf_db_wordpress"
  }
}

resource "null_resource" "config_ec2_install_wordpress" {

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("id_rsa")
    host        = aws_instance.ec2_wordpress.public_ip

  }
  provisioner "remote-exec" {
    inline = [
      "sudo yum install httpd -y",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",
      "sudo wget https://wordpress.org/wordpress-5.7.2.tar.gz",
      "sudo tar -xzf wordpress-5.7.2.tar.gz",
      "sudo cp -r wordpress/* /var/www/html/"
    ]
  }

}

resource "null_resource" "config_ec2_config_wordpress" {

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("id_rsa")
    host        = aws_instance.ec2_wordpress.public_ip

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
