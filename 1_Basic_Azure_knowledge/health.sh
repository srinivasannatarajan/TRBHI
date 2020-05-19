#! /bin/bash
printf "Memory\t\tDisk\t\tCPU\t\n"
MEMORY=$(free -m | awk 'NR==2{printf "%.2f%%\t\t", $3*100/$2 }')
DISK=$(df -h | awk '$NF=="/"{printf "%s\t\t", $5}')
CPU=$(top -bn1 | grep load | awk '{printf "%.2f%%\t\t\n", $(NF-2)}')
NETWORK=$(netstat -i)
echo "$MEMORY$DISK$CPU\nNETWORK $NETWORK"
exec $@
