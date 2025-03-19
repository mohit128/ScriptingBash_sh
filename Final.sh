#!/bin/bash

echo "======== System Health Report - $(date +"%Y-%m-%d %H:%M:%S") ========"

disk=$(df -h / | awk NR==2'{print $5}' | sed 's/%//g')
MemU=$(free -m | awk 'NR==2 {printf "%.0f\n", $3/$2*100}')
LAvg=$( uptime | awk '{printf "%.1f\n", $10 }' | tr -s "
" | tr -d ,)
SerFail=$( sudo systemctl --failed | tail -1)
ZombieP=$(ps aux | awk '{if ($8=="Z") print $2}')
isAct=$(sudo systemctl is-active $1)
UsrChk=$(id -u $2  /dev/null)
portL=$( sudo netstat -tunlp | grep :$3 | awk '{print $6 , $7}')
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

        if [ $1 -gt 70 ];then
                echo -e "Need to check memory is running out $1% .... \xE2\x9D\x8C"
		echo -e "Need to check memory is running out $1% .... \xE2\x9D\x8C \n\nHello,\n\nYour system memory usage is very high\nSeverity: Warning ;" | s-nail -s "Memory Usage Alert" mohitpar128@gmail.com
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
       #r=$(echo "$LAvg > 2.0" | bc)

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





IsActive () {
        #r=$(echo "$LAvg > 2.0" | bc)

        if [[ $1 != "active" ]];then
                echo -e "Service is  $1 .... \xE2\x9D\x8C"
                return 1
        else
                echo -e "Service is active \xE2\x9C\x85"
                return 0
        fi
}


IsActive "$isAct"

Pehchan () {
        #r=$(echo "$LAvg > 2.0" | bc)
	user=$2
        if [ -z "$1" ];then
                echo -e "User $user is not present  .... \xE2\x9D\x8C"
                return 1
        else
                echo -e "User presernt $user \xE2\x9C\x85"
                return 0
        fi
}

Pehchan "$UsrChk"


PortChk () {
        #r=$(echo "$LAvg > 2.0" | bc)

        if [ -z "$1" ];then
                echo -e "Port is not listening $portL  .... \xE2\x9D\x8C"
                return 1
        else
                echo -e "Port is active $portL \xE2\x9C\x85"
                return 0
        fi
}

PortChk "$portL"

