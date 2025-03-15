#!/bin/bash



#Disk checking

disk=$(ssh mohit@172.23.184.63 df -h / | tail -1 | tr -s " " | awk '{print $5}' | cut -d "%" -f1)

while true; do
	disk=$(ssh mohit@172.23.184.63 df -h / | tail -1 | tr -s " " | awk '{print $5}' | cut -d "%" -f1)

	echo "Checking Disk /"
	if [ $disk -gt 75 ]; then
		echo "ERROR : Size jyada hai check kr ..."
		break
	fi
	sleep 5
done








