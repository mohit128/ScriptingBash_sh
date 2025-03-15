#!/bin/bash

log_file="/var/log/logbackup.log"
date=$(date -d "yesterday" +%Y-%m-%d)
disk=$(ssh root@192.168.174.130 df -h /logbackup | tail -1 | tr -s " " | awk '{print $5}' | cut -d'%' -f1)

# Clear the log file
> "$log_file"

if [ "$disk" -gt 95 ]; then
    echo "Backup bounce hoga kyuki 95% hai size" >> "$log_file"
else
    echo "$date Backup completed" >> "$log_file"
    /home/ansible/ScriptingLearning/logbackup.sh
fi


















