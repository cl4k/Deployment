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


clear
echo  "$_PURPLE"
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


echo "$_PURPLE Username ? (Default: 'lramard')$_DEF"
read Username
Username=${Username:-"lramard"}

echo "$_PURPLE Port ? (Default: '5022')$_DEF"
read Port
Port=${Port:-"5022"}

echo "$_PURPLE Hostaddress ? (Default: '127.0.0.1')$_DEF"
read Hostaddress
Hostaddress=${Hostaddress:-"127.0.0.1"}

echo "$_PURPLE Would you like to delete known_hosts file? (yes - no)$_DEF"
read input
if [ "$input" == "yes" ]; then
	rm ~/.ssh/known_hosts
fi

echo "$_PURPLE Generating ssh key$_DEF"
ssh-keygen
ssh-copy-id -i ~/.ssh/id_rsa $Username@$Hostaddress -p $Port

scp -P $Port $PWD/install.sh $Username@$Hostaddress:~/
scp -P $Port $PWD/check-crontab.sh $Username@$Hostaddress:~/
scp -P $Port $PWD/website_update.sh $Username@$Hostaddress:~/
scp -P $Port $PWD/index.html $Username@$Hostaddress:~/
scp -P $Port $PWD/ports.conf $Username@$Hostaddress:~/
scp -P $Port $PWD/gogol.conf $Username@$Hostaddress:~/
scp -P $Port $PWD/deployssl.sh $Username@$Hostaddress:~/
echo "$_PURPLE Connecting with Username $Username, in Port $Port, at address $Hostaddress.$_DEF\n"

echo "$_PURPLE Connecting to ssh...$_DEF"
ssh $Username@$Hostaddress -p $Port
echo "\nAfter launching the install script, you should add bridged adapter in your vm"
echo "$_PURPLE Would you like to add it ? (yes - no)$_DEF"
read input
if [ "$input" == "yes" ]; then
	echo "VM name?"
	read vmname
	VBoxManage modifyvm $vmname --acpi on --boot1 dvd --nic2 bridged --bridgeadapter1 eth0
fi


