#!/bin/bash

# Colors
_BLACK='\033[30m'
_RED='\033[31m'
_GREEN='\033[32m'
_YELLOW='\033[33m'
_BLUE='\033[34m'
_PURPLE='\033[35m'
_CYAN='\033[36m'
_GREY='\033[37m'

# Text format
_DEF='\033[0m'
_GRAS='\033[1m'
_SOUL='\033[4m'
_CLIG='\033[5m'
_SURL='\033[7m'


echo "\n"
echo "$_GREEN==================================================================$_DEF\n"
echo "$_GREEN			installing package..."
echo "$_GREEN==================================================================$_DEF\n"
apt-get install -y apache2-utils
echo "$_GREEN==================================================================$_DEF\n"
apt-get install -y mysql-client
echo "$_GREEN==================================================================$_DEF\n"
apt-get install -y mysql-server
echo "$_GREEN==================================================================$_DEF\n"
apt-get install -y php7.0
echo "$_GREEN==================================================================$_DEF\n"
apt-get install -y php7.0-mysql
echo "$_GREEN==================================================================$_DEF\n"
apt-get install -y libapache2-mod-php7.0
echo "$_GREEN==================================================================$_DEF\n"
apt-get install -y php7.0-cli
echo "$_GREEN==================================================================$_DEF\n"
apt-get install -y php7.0-cgi
echo "$_GREEN==================================================================$_DEF\n"
apt-get install -y php7.0-gd
echo "$_GREEN==================================================================$_DEF\n"
echo "\n"
echo "$_GREEN==================================================================$_DEF\n"
echo "$_GREEN			installing Mysql_secure..."
echo "$_GREEN==================================================================$_DEF\n"
mysql_secure_installation

echo "<?php" >> /var/www/html/info.php
echo "phpinfo();" >> /var/www/html/info.php
echo "?>" >> /var/www/html/info.php

echo "\n"
echo "$_GREEN==================================================================$_DEF\n"
echo "$_GREEN			downloading wordpress..."
echo "$_GREEN==================================================================$_DEF\n"
wget -c http://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz

rsync -av wordpress/* /var/www/html/
chown -R www-data:www-data /var/www/html/
chmod -R 755 /var/www/html/

echo "\n"
echo "$_GREEN==================================================================$_DEF\n"
echo "$_GREEN			configurating Mysql, please follow..."
echo "$_GREEN==================================================================$_DEF\n"
echo "$_GREEN Welcome, type a name for your database : $_DEF"
read databasename
echo "$_GREEN Type a username : $_DEF"
read username
echo "$_GREEN Type a password: $_DEF"
read passwordsql

mysql -u root -p

CREATE DATABASE $databasename;
GRANT ALL PRIVILEGES ON $databasename.* TO '$username'@'localhost' IDENTIFIED BY '$passwordsql';
FLUSH PRIVILEGES;
EXIT;

echo "$_GREEN==================================================================$_DEF\n"
cd /var/www/html/
mv wp-config-sample.php wp-config.php

var1='define('DB_NAME', 'database_name_here');'
var2='define('DB_NAME', '$databasename');'
sed -i -e 's/'"$var1"'/'"$var2"'/g' wp-config.php

vari1='define('DB_USER', 'username_here');'
vari2='define('DB_USER', '$username');'
sed -i -e 's/'"$vari1"'/'"$vari2"'/g' wp-config.php

vark1='define('DB_PASSWORD', 'password_here');'
vark2='define('DB_PASSWORD', '$passwordsql');'
sed -i -e 's/'"$vark1"'/'"$vark2"'/g' wp-config.php

systemctl restart apache2.service
systemctl restart mysql.service