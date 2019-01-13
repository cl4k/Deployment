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
echo "$_GREEN			Updating...."
echo "$_GREEN==================================================================$_DEF\n"

cd /var/www/web_deploy
git pull -q

rm /var/www/html/*
cp /var/www/web_deploy/* /var/www/html/