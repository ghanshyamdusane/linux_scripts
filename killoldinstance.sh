#!/bin/bash
#Author and Maintained by : Ghanshyam Dusane
#This will delete the instances older than a day
CURRDATE=$(date | awk '{print $3}')
if [ "$CURRDATE" -eq 1 ] ;then
ps aux | grep scheduler | grep `date +'%b' -d 'last month'` | awk '{print $2}' | xargs kill -9
ps aux | grep scheduler | grep `date +'%Y' -d 'last year'` | awk '{print $2}' | xargs kill -9
else
ps aux | grep scheduler | grep `date +'%b'` | awk '{print $2}' | xargs kill -9
fi
