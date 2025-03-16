#!/bin/bash
set -x
sudo mkdir -p /home/ansible/ScriptingLearning/For_Bkp
sudo cd /var/log/

for f in /var/log/*.log; do
	
	rsync -avr $f root@192.168.174.129:/home/ansible/ScriptingLearning/For_Bkp

done

