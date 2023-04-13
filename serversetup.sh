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
# verify this later by running 'groups' in cli
sudo chown -R ec2-user:apache /var/www
sudo chmod 2775 /var/www && find /var/www -type d -exec sudo chmod 2775 {} \;
find /var/www -type f -exec sudo chmod 0664 {} \;

# Secure the database server
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

# Install phpMyAdmin to manage the DB
sudo yum install php-mbstring php-xml -y
sudo systemctl restart httpd
sudo systemctl restart php-fpm
cd /var/www/html
wget https://files.phpmyadmin.net/phpMyAdmin/5.2.1/phpMyAdmin-5.2.1-all-languages.tar.gz
mkdir phpMyAdmin && tar -xvzf phpMyAdmin-5.2.1-all-languages.tar.gz -C phpMyAdmin --strip-components 1
rm phpMyAdmin-5.2.1-all-languages.tar.gz

# To allow https, enable TLS and install an SSL cert https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/SSL-on-amazon-linux-2.html

# Download and extract WordPress
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
mkdir /var/www/html/blog
cp -r /var/www/html/wordpress/* /var/www/html/blog/
rm -rf /var/www/html/wordpress/
rm -f latest.tar.gz

# Create a database and user for WordPress

touch create-db.sql
cat <<EOT >> create-db.sql
CREATE DATABASE \`wordpress-db\`;
CREATE USER 'wordpress-user'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON \`wordpress-db\`.* TO 'wordpress-user'@'localhost';
FLUSH PRIVILEGES;
EOT
mysql -u root -p"password" < create-db.sql
rm create-db.sql

# Configure WordPress
cp /var/www/html/blog/wp-config-sample.php /var/www/html/blog/wp-config.php
sudo sed -i "s/database_name_here/wordpress-db/g" /var/www/html/blog/wp-config.php
sudo sed -i "s/username_here/wordpress-user/g" /var/www/html/blog/wp-config.php
sudo sed -i "s/password_here/password/g" /var/www/html/blog/wp-config.php

# Key and salts can be used to provide an extra layer of encryption

# Allow WordPress to use permalinks
sudo sed -i "515s/AllowOverride None/AllowOverride All/" /etc/httpd/conf/httpd.conf

# To install the PHP graphics drawing library on Amazon Linux 2
sudo yum install php-gd

# Set permissions for WordPress
sudo chown -R apache /var/www
sudo chown -R apache /var/www
sudo chmod 2775 /var/www
find /var/www -type d -exec sudo chmod 2775 {} \;
find /var/www -type f -exec sudo chmod 0644 {} \;

# Restart Apache
sudo systemctl restart httpd

# ensure that the httpd and database services start at every system boot.
sudo systemctl enable httpd && sudo systemctl enable mariadb
