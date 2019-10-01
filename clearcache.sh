#!/bin/bash
# Author and Maintained by : Ghanshyam Dusane
# To Clear Page cache whenever Memory Utilization hits to 70%

ramusage=$(free | awk '/Mem/{printf("RAM Usage: %.2f\n"), $3/$2*100}'| awk '{print $3}' | cut -d "." -f1)
if [ $ramusage -gt 70 ]; then
echo 1 > /proc/sys/vm/drop_caches
echo "`date +%c`: Memory used% is $ramusage , clearing cache" >> /var/log/clearcache.log
else
echo "memory Usage is $ramusage"
fi
