#!/bin/bash

## Server set up script on an amazon-linux-2 server

## Install php, mariadb and apache web server
sudo yum update -y
sudo amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
sudo yum install -y httpd mariadb-server

## Start apache
sudo systemctl start httpd
sudo systemctl enable httpd
# test
echo "<h1>Hellow World" > /var/www/html/index.html
# verify  httpd is running: "sudo systemctl is-enabled httpd"

