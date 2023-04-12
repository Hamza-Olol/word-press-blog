#!/bin/bash

## Server set up script on an amazon-linux-2 server

## Install php, mariadb and apache web server
sudo yum update -y
sudo amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
sudo yum install -y httpd mariadb-server

## Start apache
sudo systemctl start httpd
sudo systemctl enable httpd
# verify  httpd is running: "sudo systemctl is-enabled httpd"

sudo usermod -a -G apache ec2-user
# exit
sudo chown -R ec2-user:apache /var/www
sudo chmod 2775 /var/www && find /var/www -type d -exec sudo chmod 2775 {} \;
find /var/www -type f -exec sudo chmod 0664 {} \;

# Install phpMyAdmin
sudo yum install php-mbstring php-xml -y
sudo systemctl restart httpd
sudo systemctl restart php-fpm
cd /var/www/html
wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz
mkdir phpMyAdmin && tar -xvzf phpMyAdmin-latest-all-languages.tar.gz -C phpMyAdmin --strip-components 1
rm phpMyAdmin-latest-all-languages.tar.gz

sudo systemctl start mariadb
sudo mysql_secure_installation <<EOF

y
password
password
y
y
y
y
EOF

# Download and extract WordPress
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
mkdir /var/www/html/blog
mv /var/www/html/wordpress/* /var/www/html/blog
rm -rf /var/www/html/wordpress/
rm -f latest.tar.gz


# Create a database and user for WordPress
# mysql -u root -ppassword <<EOF
sudo systemctl start mariadb
mysql -u root -p <<EOF
CREATE USER 'wordpress-user'@'localhost' IDENTIFIED BY 'password';
CREATE DATABASE `wordpress-db`;
GRANT ALL PRIVILEGES ON `wordpress-db` TO "wordpress-user"@"localhost";
FLUSH PRIVILEGES;
EOF

# Configure WordPress
mv /var/www/html/blog/wp-config-sample.php /var/www/html/blog/wp-config.php
sudo sed -i "s/database_name_here/wordpress-db/g" /var/www/html/blog/wp-config.php
sudo sed -i "s/username_here/wordpress-user/g" /var/www/html/blog/wp-config.php
sudo sed -i "s/password_here/password/g" /var/www/html/blog/wp-config.php

# Set permissions for WordPress
sudo chown -R apache /var/www
sudo chown -R apache /var/www
sudo chmod 2775 /var/www
find /var/www -type d -exec sudo chmod 2775 {} \;

sudo sed -i "515s/AllowOverride None/AllowOverride All/" /etc/httpd/conf/httpd.conf

# # Set permissions for WordPress
# # # chown -R apache:apache /var/www/html/
# # # chmod -R 755 /var/www/html/
# sudo chown -R apache /var/www
# sudo chgrp -R apache /var/www
# sudo chmod 2775 /var/www
# find /var/www -type d -exec sudo chmod 2775 {} \;\find /var/www -type f -exec sudo chmod 0644 {} \;

# Restart Apache
sudo systemctl restart httpd
sudo systemctl enable httpd && sudo systemctl enable mariadb

# To install the PHP graphics drawing library on Amazon Linux 2
sudo yum install php-gd