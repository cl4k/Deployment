#!/bin/bash

FL=$(cat crontab.checksum | awk '{print $1}')
CA=$(md5sum /etc/crontab | awk '{print $1}')

if [ "$FL" != "$CA" ]; then
	echo "file crontab have been modified" | sendmail root
else
	echo "OK"
fi

md5sum /etc/crontab > crontab.checksum