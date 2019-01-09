#!/bin/bash
if [ `grep '/var/dailymysqlbackup/dailymysqlbackup.sh' /var/spool/cron/root |wc -l` -gt 0 ] ;then
replace '/var/dailymysqlbackup/dailymysqlbackup.sh' '/var/dailymysqlbackup/dailymysqlbackup.sh' -- /var/spool/cron/root
service crond restart
fi
if [ `grep '/var/dailymysqlbackup/dailymysqlbackup.sh' /var/spool/cron/root |wc -l` -eq 0 ] ;then
echo "45 0 * * * sh /var/dailymysqlbackup/dailymysqlbackup.sh >/dev/null 2>&1" >> /var/spool/cron/root
fi

DBS="$(mysql -u admin -p`cat /etc/psa/.psa.shadow` -h localhost -Bse 'show databases')"
echo > /var/dailymysqlbackup/dbslist
for db in $DBS
do
if [ $db != "information_schema" ] && [ $db != "cphulkd" ] && [ $db != "leechprotect" ] && [ $db != "eximstats" ] && [ $db != "modsec" ]; then
echo $db >> /var/dailymysqlbackup/dbslist
fi
done
for i in `cat /var/dailymysqlbackup/dbslist` ; do
/usr/bin/mysqldump --user=admin -p`cat /etc/psa/.psa.shadow` --protocol=socket --socket="/var/lib/mysql/mysql.sock" --skip-add-locks $i | /bin/gzip -9 > /var/dailymysqlbackup/databases/$i.sql.gz
done
