
clear
echo "$_PURPLE"
echo " ██▓███   ▒█████   █     █░▓█████  ██▀███      ██▀███   ▒█████    ▄████ ▓█████  ██▀███"
echo "▓██░  ██▒▒██▒  ██▒▓█░ █ ░█░▓█   ▀ ▓██ ▒ ██▒   ▓██ ▒ ██▒▒██▒  ██▒ ██▒ ▀█▒▓█   ▀ ▓██ ▒ ██▒"
echo "▓██░ ██▓▒▒██░  ██▒▒█░ █ ░█ ▒███   ▓██ ░▄█ ▒   ▓██ ░▄█ ▒▒██░  ██▒▒██░▄▄▄░▒███   ▓██ ░▄█ ▒"
echo "▒██▄█▓▒ ▒▒██   ██░░█░ █ ░█ ▒▓█  ▄ ▒██▀▀█▄     ▒██▀▀█▄  ▒██   ██░░▓█  ██▓▒▓█  ▄ ▒██▀▀█▄"
echo "▒██▒ ░  ░░ ████▓▒░░░██▒██▓ ░▒████▒░██▓ ▒██▒   ░██▓ ▒██▒░ ████▓▒░░▒▓███▀▒░▒████▒░██▓ ▒██▒"
echo "▒▓▒░ ░  ░░ ▒░▒░▒░ ░ ▓░▒ ▒  ░░ ▒░ ░░ ▒▓ ░▒▓░   ░ ▒▓ ░▒▓░░ ▒░▒░▒░  ░▒   ▒ ░░ ▒░ ░░ ▒▓ ░▒▓░"
echo "░▒ ░       ░ ▒ ▒░   ▒ ░ ░   ░ ░  ░  ░▒ ░ ▒░     ░▒ ░ ▒░  ░ ▒ ▒░   ░   ░  ░ ░  ░  ░▒ ░ ▒░"
echo "░░       ░ ░ ░ ▒    ░   ░     ░     ░░   ░      ░░   ░ ░ ░ ░ ▒  ░ ░   ░    ░     ░░   ░"
echo "             ░ ░      ░       ░  ░   ░           ░         ░ ░        ░    ░  ░   ░" 
echo  "$_DEF"

sleep 1

rm /var/www/html/index.html
cp /home/lramard/index.html /var/www/html/index.html
echo "$_PURPLE==================================================================$_DEF\n"
mkdir -p /etc/ssl/localcerts
openssl req -new -x509 -days 365 -nodes -out /etc/ssl/localcerts/apache.pem -keyout /etc/ssl/localcerts/apache.key
chmod 600 /etc/ssl/localcerts/apache*
a2enmod ssl
systemctl restart apache2
cp /home/lramard/gogol.conf /etc/apache2/sites-available/
a2ensite gogol.conf
a2dissite default-ssl.conf
a2dissite 000-default.conf
rm /etc/apache2/ports.conf
mv /home/lramard/ports.conf /etc/apache2/ports.conf
systemctl restart apache2
