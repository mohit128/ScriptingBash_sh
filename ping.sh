#!/bin/bash

while true; do
	f=0
	ping=$(ping -c 1 $1 | awk '{print substr($5,10)}')
	
	if [[ $f -eq 0 && $ping -eq 1 ]]; then
		echo "Reachable hai server ...."
	else
		echo "ERROR : Unreachable...."
		break

	fi
        sleep 3
done
	
