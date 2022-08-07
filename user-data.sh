#! /bin/bash
sudo yum update -y
sudo yum update -y
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
cd /var/www/html
sudo wget https://wordpress.org/latest.tar.gz
sudo tar -xzf latest.tar.gz
cd
sudo amazon-linux-extras enable php7.2
sudo yum clean metadata -y
sudo yum install php-cli php-pdo php-fpm php-json php-mysqlnd -y
sudo systemctl restart httpd