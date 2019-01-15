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

echo "$_PURPLE Welcome, type a name for your vm : $_DEF"
read vmname

echo "\n"
echo "$_PURPLE By default, your vm named $vmname will be create with a debian iso.$_DEF"
echo "\n"

ostype="Debian_64"
isofile="$PWD/debian.iso"

## Memory and video memory in MB

vmsize=8192
vmmemory="2048"
vmvram="128"
echo "\n## Default memory set to 4096 and vram to 128. ##\n"

## Hard disk size in MB

hddsize="8192"


vboxmanage createvm --name $vmname --ostype $ostype --register
echo "$_PURPLE==================================================================$_DEF\n"

echo "\nSETTING UP MEDIUM DISK\n"
VBoxManage createmedium disk --filename /sgoinfre/goinfre/Perso/lramard/$vmname.vdi --size $vmsize --variant Fixed
echo "$_PURPLE==================================================================$_DEF\n"

echo "\nSETTING UP SATA CONTROLLER\n"
VBoxManage storagectl $vmname --name "SATA Controller" --add sata --controller IntelAhci
VBoxManage storageattach $vmname --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium /sgoinfre/goinfre/Perso/lramard/$vmname.vdi
echo "$_PURPLE==================================================================$_DEF\n"

echo "\nSETTING UP MEMORY AND VMEMORY\n"
VBoxManage modifyvm $vmname --memory $vmmemory --vram $vmvram
echo "$_PURPLE==================================================================$_DEF\n"

echo "\nSETTING UP NAT\n"
VBoxManage modifyvm $vmname --acpi on --boot1 dvd --nic1 nat

echo "$_PURPLE==================================================================$_DEF\n"

echo "\nSETTING UP SSH PORT\n"
VBoxManage modifyvm $vmname --natpf1 "SSH,tcp,127.0.0.1,5022,,22"
echo "$_PURPLE==================================================================$_DEF\n"
VBoxManage modifyvm $vmname --natpf1 "HTTP,tcp,,80,,80"
echo "$_PURPLE==================================================================$_DEF\n"
VBoxManage modifyvm $vmname --natpf1 "HTTPS,tcp,,443,,443"
echo "$_PURPLE==================================================================$_DEF\n"

echo "\nSETTING UP IDE CONTROLLER\n"
VBoxManage storagectl $vmname --name "IDE Controller" --add IDE
VBoxManage storageattach $vmname --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium $PWD/debian.iso
echo "$_PURPLE==================================================================$_DEF\n"

echo "\nSTARTING VM\n"
VBoxManage startvm $vmname
echo "$_PURPLE==================================================================$_DEF\n"