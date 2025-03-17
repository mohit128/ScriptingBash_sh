#!/bin/bash

echo "======== System Health Report - $(date +"%Y-%m-%d %H:%M:%S") ========"

disk=$(df -h / | awk NR==2'{print $5}' | sed 's/%//g')
MemU=$(free -m | awk 'NR==2 {printf "%.0f\n", $3/$2*100}')
LAvg=$( uptime | awk '{printf "%.1f\n", $10 }' | tr -s "
" | tr -d ,)
SerFail=$( sudo systemctl --failed | tail -1)
ZombieP=$(ps aux | awk '{if ($8=="Z") print $2}')

diskUsage () {
	
	if [ $1 -gt 75 ];then
		echo -e "Need to check space is running out $1 .... \xE2\x9D\x8C"
		return 1
	else
		echo -e "Disk Space Under threshold! \xE2\x9C\x85 "	
		return 0
	fi
}

diskUsage "$disk"

MemoryUsage () {

        if [ $1 -gt 75 ];then
                echo -e "Need to check memory is running out $1 .... \xE2\x9D\x8C"
                return 1
        else
                echo -e "Memory Usage Under threshold! \xE2\x9C\x85"
                return 0
        fi
}


MemoryUsage $MemU

LoadAvg () {
	r=$(echo "$LAvg > 2.0" | bc)

        if [ $r -eq 1 ];then
                echo -e "Need to check memory is running out $1 .... \xE2\x9D\x8C"
                return 1
        else
                echo -e "LoadAverage Under threshold! \xE2\x9C\x85"
                return 0
        fi
}


LoadAvg "$LAvg"


ServiceFail () {
        

        if [[ $1 != "0 loaded units listed." ]];then
                echo -e "Need to check failed service \xE2\x9D\x8C"
		echo $1
		echo "Troubloshooting steps"
		echo "$(sudo cat /home/ansible/ScriptingLearning/systemFailed.txt)" 
                return 1
        else
                echo -e "$1 \xE2\x9C\x85"
                return 0
        fi
}

ServiceFail "$SerFail"



ZombieProcess () {
       # r=$(echo "$LAvg > 2.0" | bc)

        if [ -n "$1" ];then
                echo -e "\xE2\x9D\x8C Need to kill zombie process $1  \xE2\x9D\x8C"
		for pid in "$1"; do

			echo "Killing pid : $pid" 
			sudo kill -9 $pid
		done
		return 1
        else
                echo -e "No Zombie Process Found  \xE2\x9C\x85"
                return 0
        fi
}

ZombieProcess "$ZombieP"






