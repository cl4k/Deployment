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

echo "\n"
echo "$_PURPLE==================================================================$_DEF\n"
echo "$_PURPLE			debian disk infos :"
echo "$_PURPLE==================================================================$_DEF\n"
fdisk -l

echo "\n 1 sector = 512 b\n"

echo "\n"
echo "$_PURPLE==================================================================$_DEF\n"
echo "$_PURPLE			updating..."
echo "$_PURPLE==================================================================$_DEF\n"
apt-get -y update
echo "$_PURPLE==================================================================$_DEF\n"
apt-get -y upgrade

echo "\n"
echo "$_PURPLE==================================================================$_DEF\n"
echo "$_PURPLE			installing package..."
echo "$_PURPLE==================================================================$_DEF\n"
apt-get install -y sudo
echo "$_PURPLE==================================================================$_DEF\n"
apt-get install -y fail2ban
echo "$_PURPLE==================================================================$_DEF\n"
apt-get install -y apache2
echo "$_PURPLE==================================================================$_DEF\n"
apt-get install -y vim
echo "$_PURPLE==================================================================$_DEF\n"
apt-get install -y iptables-persistent
echo "$_PURPLE==================================================================$_DEF\n"
apt-get install -y netfilter-persistent
echo "$_PURPLE==================================================================$_DEF\n"
apt-get install -y openssl
echo "$_PURPLE==================================================================$_DEF\n"
apt-get install -y nmap
echo "$_PURPLE==================================================================$_DEF\n"
apt-get install -y net-tools
echo "$_PURPLE==================================================================$_DEF\n"
apt-get install -y openssl
echo "$_PURPLE==================================================================$_DEF\n"
apt-get install -y git
echo "$_PURPLE==================================================================$_DEF\n"
apt-get install -y sendmail
echo "$_PURPLE==================================================================$_DEF\n"
echo "\n"
echo "Adding sudo user... Username ? (default: 'tom')"
read Username
Username=${Username:-"tom"}
adduser $Username
adduser $Username sudo

echo "\n"
echo "$_PURPLE==================================================================$_DEF\n"
echo "$_PURPLE			LAN ADDR"
echo "$_PURPLE==================================================================$_DEF\n"

cp /etc/network/interfaces /etc/network/interfaces-save
var1='iface enp0s3 inet dhcp'
var2='iface enp0s8 inet static'
sed -i -e 's/'"$var1"'/'"$var2"'/g' /etc/network/interfaces
var1='allow-hotplug enp0s3'
var2='allow-hotplug enp0s8'
sed -i -e 's/'"$var1"'/'"$var2"'/g' /etc/network/interfaces
echo "Dans que cluster etes-vous ?"
read Cluster
Cluster=${Cluster:-"2"}
echo "\taddress 10.1$Cluster.254.148\n\tgateway 10.1$Cluster.254.254\n\tnetmask 255.255.255.252\n\tdns-nameservers 8.8.8.8 10.1$Cluster.254.254" >> /etc/network/interfaces

echo "\n"
echo "$_PURPLE==================================================================$_DEF\n"
echo "$_PURPLE			SSHD_CONFIG"
echo "$_PURPLE==================================================================$_DEF\n"

cp /etc/ssh/sshd_config /etc/ssh/sshd_config-save

var1='#Port 22'
var2='Port 5022'
sed -i -e 's/'"$var1"'/'"$var2"'/g' /etc/ssh/sshd_config

var1='#PermitRootLogin prohibit-password'
var2='PermitRootLogin no'
sed -i -e 's/'"$var1"'/'"$var2"'/g' /etc/ssh/sshd_config

var1='#PubkeyAuthentication yes'
var2='PubkeyAuthentication yes'
sed -i -e 's/'"$var1"'/'"$var2"'/g' /etc/ssh/sshd_config

sed -i -e 's/'"#PasswordAuthentication yes"'/'"PasswordAuthentication no"'/g' /etc/ssh/sshd_config

echo "\n"
echo "$_PURPLE==================================================================$_DEF\n"
echo "$_PURPLE			HOST_CONFIG FORT MAIL"
echo "$_PURPLE==================================================================$_DEF\n"

cp /etc/hosts /etc/hosts-save

echo "Host name? (default : debian)"
read host
host=${host:-"debian"}

var1='127.0.0.1	localhost'
var2='127.0.0.1	localhost.localdomain localhost debian'
sed -i -e 's/'"$var1"'/'"$var2"'/g' /etc/hosts

echo "\n"
echo "$_PURPLE==================================================================$_DEF\n"
echo "$_PURPLE			FIREWALL_CONFIG"
echo "$_PURPLE==================================================================$_DEF\n"

rm -rf /etc/iptables/rules.v4

echo "*filter\n:INPUT DROP [0:0]\n:FORWARD DROP [0:0]\n:OUTPUT DROP [0:0]\n" >> /etc/iptables/rules.v4

echo "# continue connections that are already established or related to an established connection\n" >> /etc/iptables/rules.v4
echo "-A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT\n" >> /etc/iptables/rules.v4
echo "-A OUTPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT\n\n" >> /etc/iptables/rules.v4

echo "# SSH\n" >> /etc/iptables/rules.v4
echo "-A INPUT -p tcp -m tcp --dport 5022 -j ACCEPT\n" >> /etc/iptables/rules.v4
echo "-A OUTPUT -p tcp -m tcp --dport 5022 -j ACCEPT\n" >> /etc/iptables/rules.v4
echo "\n#mail\n" >> /etc/iptables/rules.v4
echo "-A INPUT -p tcp --dport 25 -j ACCEPT\n"  >> /etc/iptables/rules.v4
echo "-A OUTPUT -p tcp --dport 25 -j ACCEPT\n" >> /etc/iptables/rules.v4
echo "\n# authorise hht\n" >> /etc/iptables/rules.v4
echo "-A INPUT -p tcp -m multiport --dports 80,443 -j ACCEPT\n\n" >> /etc/iptables/rules.v4
echo "-A OUTPUT -p tcp -m multiport --dports 80,443 -j ACCEPT\n\n" >> /etc/iptables/rules.v4

echo "## authorise apt-get\n" >> /etc/iptables/rules.v4

echo "-A OUTPUT -m state --state RELATED,ESTABLISHED -j ACCEPT\n" >> /etc/iptables/rules.v4
echo "-A OUTPUT -p udp --dport 53 -m state --state NEW -j ACCEPT\n" >> /etc/iptables/rules.v4
echo "-A OUTPUT -p tcp --dport 53 -m state --state NEW -j ACCEPT\n" >> /etc/iptables/rules.v4
echo "-A INPUT -m state --state NEW -p tcp --dport 443 -j ACCEPT\n" >> /etc/iptables/rules.v4

echo "# Drop non-conforming parcket, such as malformede headers, etc.\n" >> /etc/iptables/rules.v4
echo "-A INPUT -m conntrack --ctstate INVALID -j DROP\n" >> /etc/iptables/rules.v4

echo "# chain for preventing ping flooding - up to 6 signs per second from a single \n# source again with tlog limiting. Also prevents from IMCP REPLY flooding \n# some victim when replying to IMCP ECHO from a spoofed source. \n" >> /etc/iptables/rules.v4

echo "-N ICMPFLOOD\n" >> /etc/iptables/rules.v4
echo "-A ICMPFLOOD -m recent --name ICMP --set --rsource\n" >> /etc/iptables/rules.v4
echo "-A ICMPFLOOD -m recent --name ICMP --update --seconds 30 --hitcount 6 --rsource --rttl -m limit --limit 1/sec --limit-burst 1 -j LOG --log-prefix "iptables[ICMP-flood]: "\n" >> /etc/iptables/rules.v4
echo "-A ICMPFLOOD -m recent --name ICMP --update --second 30 --hitcount 6 --rsource --rttl -j DROP\n" >> /etc/iptables/rules.v4
echo "-A ICMPFLOOD -j ACCEPT \n\n" >> /etc/iptables/rules.v4

echo "# Permit useful IMCP packet types. \n# Note: RFC 792 states that all hosts MUST respond to IMCP ECHO requests. \n#Blocking these can make diagnosing of even simple faults much more tricky. \n# Real security lies in locking down and hardening all services, not by hinding \n" >> /etc/iptables/rules.v4

echo "-A INPUT -p icmp --icmp-type 0 -m conntrack --ctstate NEW -j ACCEPT\n" >> /etc/iptables/rules.v4
echo "-A INPUT -p icmp --icmp-type 3 -m conntrack --ctstate NEW -j ACCEPT \n" >> /etc/iptables/rules.v4
echo "-A INPUT -p icmp --icmp-type 8 -m conntrack --ctstate NEW -j ICMPFLOOD\n" >> /etc/iptables/rules.v4
echo "-A INPUT -p icmp --icmp-type 11 -m conntrack --ctstate NEW -j ACCEPT\n\n" >> /etc/iptables/rules.v4

echo "# Drop all incoming malformed NULL packets\n" >> /etc/iptables/rules.v4
echo "-A INPUT -p tcp --tcp-flags ALL NONE -j DROP\n\n" >> /etc/iptables/rules.v4

echo "# Drop syn-floodattck packets\n" >> /etc/iptables/rules.v4
echo "-A INPUT -p tcp ! --syn -m conntrack --ctstate NEW -j DROP\n\n" >> /etc/iptables/rules.v4

echo "#Drop incoming malformed XMAS packets\n" >> /etc/iptables/rules.v4
echo "-A INPUT -p tcp --tcp-flags ALL ALL -j DROP\n\n" >> /etc/iptables/rules.v4

echo "#protect again scan port\n" >> /etc/iptables/rules.v4

echo "# Syn scan trapped port 22\n" >> /etc/iptables/rules.v4
echo "-A INPUT -p tcp -m multiport --dport 22 --tcp-flags ALL SYN -m recent --name portscanners --set -j DROP\n\n" >> /etc/iptables/rules.v4

echo "-A INPUT -p tcp --tcp-flags ALL ALL -m limit --limit 1/h -j ACCEPT\n" >> /etc/iptables/rules.v4
echo "-A INPUT -p tcp --tcp-flags ALL NONE -m limit --limit 1/h -j ACCEPT\n" >> /etc/iptables/rules.v4
echo "-A INPUT -p tcp --tcp-flags SYN,ACK SYN,ACK -m state --state NEW -j DROP\n" >> /etc/iptables/rules.v4
echo "-A INPUT -p tcp --tcp-flags ALL NONE -j DROP\n\n" >> /etc/iptables/rules.v4
echo "-A INPUT -p tcp --tcp-flags SYN,FIN SYN,FIN -j DROP\n" >> /etc/iptables/rules.v4
echo "-A INPUT -p tcp --tcp-flags SYN,RST SYN,RST -j DROP\n" >> /etc/iptables/rules.v4
echo "-A INPUT -p tcp --tcp-flags ALL SYN,RST,ACK,FIN,URG -j DROP\n\n" >> /etc/iptables/rules.v4
echo "-A INPUT -p tcp --tcp-flags FIN,RST FIN,RST -j DROP\n" >> /etc/iptables/rules.v4
echo "-A INPUT -p tcp --tcp-flags ACK,FIN FIN -j DROP\n" >> /etc/iptables/rules.v4

echo "-A INPUT -p tcp --tcp-flags ACK,PSH PSH -j DROP\n" >> /etc/iptables/rules.v4
echo "-A INPUT -p tcp --tcp-flags ACK,URG URG -j DROP\n" >> /etc/iptables/rules.v4
echo "-A INPUT -m recent --name portscan --rcheck --seconds 86400 -j DROP" >> /etc/iptables/rules.v4
echo "-A FORWARD -m recent --name portscan --rcheck --seconds 86400 -j DROP" >> /etc/iptables/rules.v4
echo "\nCOMMIT" >> /etc/iptables/rules.v4

echo "\n"
echo "$_PURPLE==================================================================$_DEF\n"
echo "$_PURPLE			CRON_CONFIG"
echo "$_PURPLE==================================================================$_DEF\n"

cp /etc/crontab /etc/crontab-save

rm -rf /etc/crontab

echo "SHELL=/bin.sh\n" >> /etc/crontab
echo "PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin\n\m" >> /etc/crontab

echo "# m h dom mon dow user command\n" >> /etc/crontab
echo "17 * * * * root cd / && run-parts --report /etc/cron.hourly\n" >> /etc/crontab
echo "25 6 * * * root test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.daily )\n" >> /etc/crontab
echo "47 6 * * 7 root test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.weekly )\n" >> /etc/crontab
echo "52 6 1 * * root test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.monthly )\n" >> /etc/crontab

echo "0 4 0 0 1 root /usr/bin/apt-get update | tee /var/log/update_script.log\n" >> /etc/crontab
echo "@reboot root /usr/bin/apt-get update | tee /var/log/update_script.log\n" >> /etc/crontab
echo "0 0 * * * root /root/check-file.sh" >> /etc/crontab
echo "0 4 0 0 1 /usr/bin/apt-get update | tee /var/log/update_script.log\n" >> /var/spool/cron/crontabs/root
echo "@reboot /usr/bin/apt-get update | tee /var/log/update_script.log\n" >> /var/spool/cron/crontabs/root
echo "0 0 * * * /root/check-file.sh" >> /var/spool/cron/crontabs/root

echo "\n"
echo "$_PURPLE==================================================================$_DEF\n"
echo "$_PURPLE			SCRIPT_CONFIG"
echo "$_PURPLE==================================================================$_DEF\n"

mv $PWD/check-crontab.sh /root
md5sum /etc/crontab > /root/crontab.checksum

echo "\n"
echo "$_PURPLE==================================================================$_DEF\n"
echo "$_PURPLE			Website_Config..."
echo "$_PURPLE==================================================================$_DEF\n"

git clone https://github.com/cl4k/web_deploy_RS1.git /var/www/web_deploy

echo "$_PURPLE==================================================================$_DEF\n"
echo "$_PURPLE			HOST_CONFIG FOR MAIL"
echo "$_PURPLE==================================================================$_DEF\n"

cp /etc/hosts /etc/hosts-save

var1='127.0.0.1	localhost'
var2='127.0.0.1	localhost.localdomain localhost debian'
sed -i -e 's/'"$var1"'/'"$var2"'/g' /etc/hosts

apt-get install -y sendmail

echo "$_PURPLE==================================================================$_DEF\n"
echo "$_PURPLE Server will shutdown now... change port of ssh in NAT adapter and add bridged adapter please. $_DEF\n"
shutdown now