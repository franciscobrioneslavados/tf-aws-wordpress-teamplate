#! /bin/bash
echo "ec2 install wordpress"
sudo yum install httpd wget zip -y
sudo systemctl start httpd
sudo systemctl enable httpd
sudo wget https://wordpress.org/wordpress-5.7.2.zip
sudo unzip wordpress-5.7.2.zip
sudo mv -f wordpress/* /var/www/html
sudo rm -rf wordpress wordpress-5.7.2.zip
echo "ec2 config wordpress"
sudo yum install -y amazon-linux-extras
sudo amazon-linux-extras enable php7.2
sudo yum clean metadata -y
sudo yum install php-cli php-pdo php-fpm php-json php-mysqlnd -y
sudo systemctl restart httpd
