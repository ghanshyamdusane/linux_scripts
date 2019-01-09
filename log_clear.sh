#!/bin/bash
check=$(df -h | grep -E " /" | head -n1 | cut -d "%" -f1 | awk '{print $4}')
if [[ $check -gt 75 ]]; then
echo > /var/log/messages
echo "`date +%c`: Disk used% is $check , clearing logs" >> /var/log/clearlog.log
fi
