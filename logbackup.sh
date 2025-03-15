#!/bin/bash

# Get yesterday's date components
d=$(date -d "yesterday" +%y.%m.%d)
Year=$(date -d "yesterday" +%Y)
Month=$(date -d "yesterday" +%m)
Day=$(date -d "yesterday" +%d)

# Define backup directory path
backup_dir="/logbackup/$Year/$Month/$Day/disk"

#Root=$(ssh root
ssh root@192.168.174.130 "mkdir -p $backup_dir"

# Create directory


# Secure copy logs to remote server
scp -pr /var/log/disk_usage.log.*[1..9000] root@192.168.174.130:"$backup_dir"

# Print confirmation message
echo "Backup completed to $backup_dir"



