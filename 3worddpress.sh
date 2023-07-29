#!/bin/bash
sudo apt-get update
sudo apt -y install mysql-client mysql-server
sudo apt -y install apache2
sudo apt -y install php php-mysql
#sudo apt -y install nginx
cd /tmp && wget https://wordpress.org/latest.tar.gz
#database
database1=database1
user1=user1
pass1=pass1

database1=database2
user1=user2
pass1=pass2

database1=database3
user1=user3
pass1=pass3

#create database
sudo mysql -e "CREATE DATABASE $database1;"
sudo mysql -e "CREATE USER '$user1'@'localhost' IDENTIFIED BY '$pass1';"
sudo mysql -e "GRANT ALL PRIVILEGES ON $database1.* TO '$user1'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"

sudo mysql -e "CREATE DATABASE $database2;"
sudo mysql -e "CREATE USER '$user2'@'localhost' IDENTIFIED BY '$pass2';"
sudo mysql -e "GRANT ALL PRIVILEGES ON $database2.* TO '$user2'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"

sudo mysql -e "CREATE DATABASE $database3;"
sudo mysql -e "CREATE USER '$user3'@'localhost' IDENTIFIED BY '$pass3';"
sudo mysql -e "GRANT ALL PRIVILEGES ON $database3.* TO '$user3'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"
#config wordpress
sudo tar -xvf /tmp/latest.tar.gz -C /var/www/html
sudo mv /var/www/html/wordpress /var/www/html/wordpress1
sudo cp -r /var/www/html/wordpress1 /var/www/html/wordpress2
sudo cp -r /var/www/html/wordpress1 /var/www/html/wordpress3
sudo chown -R www-data:www-data /var/www/html/
sudo chmod -R 755 /var/www/html/
sudo mkdir /var/www/html/wordpress1/wp-content/uploads
sudo mkdir /var/www/html/wordpress2/wp-content/uploads
sudo mkdir /var/www/html/wordpress3/wp-content/uploads
sudo chown -R www-data:www-data /var/www/html/wordpress1/wp-content/uploads/
sudo chown -R www-data:www-data /var/www/html/wordpress2/wp-content/uploads/
sudo chown -R www-data:www-data /var/www/html/wordpress3/wp-content/uploads/
#setting apache2
sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/wordpress1.conf
sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/wordpress2.conf
sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/wordpress3.conf
sudo sed -i 's#/var/www/html#/var/www/html/wordpress1/#' /etc/apache2/sites-available/wordpress1.conf
sudo sed -i 's#/var/www/html#/var/www/html/wordpress2/#' /etc/apache2/sites-available/wordpress2.conf
sudo sed -i 's#/var/www/html#/var/www/html/wordpress3/#' /etc/apache2/sites-available/wordpress3.conf
sudo a2dissite 000-default.conf
sudo a2ensite wordpress1.conf
sudo a2ensite wordpress2.conf
sudo a2ensite wordpress3.conf
sudo systemctl restart apache2
