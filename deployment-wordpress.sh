#!/bin/bash
sudo apt-get update
sudo apt -y install mysql-client mysql-server
sudo apt -y install apache2
sudo apt -y install php php-mysql
cd /tmp && wget https://wordpress.org/latest.tar.gz

#create database
sudo mysql -e "CREATE DATABASE wp_database;"
sudo mysql -e "CREATE USER 'wp_user'@'localhost' IDENTIFIED BY '123';"
sudo mysql -e "GRANT ALL PRIVILEGES ON wp_database.* TO 'wp_user'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"

#config wordpress
sudo tar -xvf /tmp/latest.tar.gz -C /var/www/html
sudo chown -R www-data:www-data /var/www/html/wordpress/
sudo chmod -R 755 /var/www/html/wordpress/
sudo mkdir /var/www/html/wordpress/wp-content/uploads
sudo chown -R www-data:www-data /var/www/html/wordpress/wp-content/uploads/

#setting apache2
sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/wordpress.conf
sudo sed -i 's#/var/www/html#/var/www/html/wordpress/#' /etc/apache2/sites-available/wordpress.conf
sudo a2dissite 000-default.conf
sudo a2ensite wordpress.conf
sudo systemctl restart apache2

echo "База данных: wp_database"
echo "Пользователь: wp_user"
echo "Пароль: 123"
echo "не забудьте задать root пароль для MySQL"
