#!/bin/sh
#Author and Maintained by : Ghanshyam Dusane
#Variables

SENDGRIDAPIUSER=""
SENDGRIDAPIPASSWORD=""
#EMAIL_TO=""
EMAIL_TO=""
FROM_EMAIL=""
FROM_NAME="Pipeline-Reporting"
dat=`date +%F`
SUBJECT="Pipeline-Report-$dat"


#--------------------------NAA-OFT------------------------------------------------------#

NAAOFT_dbhost=""
NAAOFT_dbusername=""
NAAOFT_dbpassword=""

#HIVE
ONNH="N/A"

#G3MS
ONNG="N/A"

#CBM
ONNC1=$(mysql -h $NAAOFT_dbhost -u $NAAOFT_dbusername -p$NAAOFT_dbpassword -e "use scheduler; select status from runbook_instance where startedat LIKE '$dat%' and runbookid=602 ORDER BY endat DESC LIMIT 1;")
echo "Fetching Data for NAA-OFT 602"
ONNC=`echo $ONNC1 | awk '{print $2}'`

#Reporting
ONNR1=$(mysql -h $NAAOFT_dbhost -u $NAAOFT_dbusername -p$NAAOFT_dbpassword -e "use scheduler; select status from runbook_instance where startedat LIKE '$dat%' and runbookid=606 ORDER BY endat DESC LIMIT 1;")
echo "Fetching Data for NAA-OFT 606"
ONNR=`echo $ONNR1 | awk '{print $2}'`

#Callback
ONNCB1=$(mysql -h $NAAOFT_dbhost -u $NAAOFT_dbusername -p$NAAOFT_dbpassword -e "use scheduler; select status from runbook_instance where startedat LIKE '$dat%' and runbookid=610 ORDER BY endat DESC LIMIT 1;")
echo "Fetching Data for NAA-OFT 610"
ONNCB=`echo $ONNCB1 | awk '{print $2}'`

#DeleteInactive
ONND1=$(mysql -h $NAAOFT_dbhost -u $NAAOFT_dbusername -p$NAAOFT_dbpassword -e "use scheduler; select status from runbook_instance where startedat LIKE '$dat%' and runbookid=611 ORDER BY endat DESC LIMIT 1;")
echo "Fetching Data for NAA-OFT 611"
ONND=`echo $ONND1 | awk '{print $2}'`

#GCS
ONNGC1=$(mysql -h $NAAOFT_dbhost -u $NAAOFT_dbusername -p$NAAOFT_dbpassword -e "use scheduler; select status from runbook_instance where startedat LIKE '$dat%' and runbookid=613 ORDER BY endat DESC LIMIT 1;")
echo "Fetching Data for NAA-OFT 613"
ONNGC=`echo $ONNGC1 | awk '{print $2}'`

#LVM
ONNL1=$(mysql -h $NAAOFT_dbhost -u $NAAOFT_dbusername -p$NAAOFT_dbpassword -e "use scheduler; select status from runbook_instance where startedat LIKE '$dat%' and runbookid=614 ORDER BY endat DESC LIMIT 1;")
echo "Fetching Data for NAA-OFT 614"
ONNL=`echo $ONNL1 | awk '{print $2}'`

#--------------------------NAA-OFT------------------------------------------------------#

#--------------------------APAC-OFT------------------------------------------------------#

APACOFT_dbhost=""
APACOFT_dbusername=""
APACOFT_dbpassword=""

#CBM
OAHC1=$(mysql -h $APACOFT_dbhost -u $APACOFT_dbusername -p$APACOFT_dbpassword -e "use scheduler; select status from runbook_instance where startedat LIKE '$dat%' and runbookid=102 ORDER BY endat DESC LIMIT 1;")
echo "Fetching Data for APAC-OFT-HKG 102"
OAHC=`echo $OAHC1 | awk '{print $2}'`

#Reporting
OAHR1=$(mysql -h $APACOFT_dbhost -u $APACOFT_dbusername -p$APACOFT_dbpassword -e "use scheduler; select status from runbook_instance where startedat LIKE '$dat%' and runbookid=106 ORDER BY endat DESC LIMIT 1;")
echo "Fetching Data for APAC-OFT-HKG 106"
OAHR=`echo $OAHR1 | awk '{print $2}'`

#HIVE
OAHH1=$(mysql -h $APACOFT_dbhost -u $APACOFT_dbusername -p$APACOFT_dbpassword -e "use scheduler; select status from runbook_instance where startedat LIKE '$dat%' and runbookid=109 ORDER BY endat DESC LIMIT 1;")
echo "Fetching Data for APAC-OFT-HKG 109"
OAHH=`echo $OAHH1 | awk '{print $2}'`

#Callback
OAHCB1=$(mysql -h $APACOFT_dbhost -u $APACOFT_dbusername -p$APACOFT_dbpassword -e "use scheduler; select status from runbook_instance where startedat LIKE '$dat%' and runbookid=110 ORDER BY endat DESC LIMIT 1;")
echo "Fetching Data for APAC-OFT-HKG 110"
OAHCB=`echo $OAHCB1 | awk '{print $2}'`

#DeleteInactive
OAHD1=$(mysql -h $APACOFT_dbhost -u $APACOFT_dbusername -p$APACOFT_dbpassword -e "use scheduler; select status from runbook_instance where startedat LIKE '$dat%' and runbookid=111 ORDER BY endat DESC LIMIT 1;")
echo "Fetching Data for APAC-OFT-HKG 111"
OAHD=`echo $OAHD1 | awk '{print $2}'`

#G3MS
OAHG1=$(mysql -h $APACOFT_dbhost -u $APACOFT_dbusername -p$APACOFT_dbpassword -e "use scheduler; select status from runbook_instance where startedat LIKE '$dat%' and runbookid=105 ORDER BY endat DESC LIMIT 1;")
echo "Fetching Data for APAC-OFT-HKG 105"
OAHG=`echo $OAHG1 | awk '{print $2}'`

#GCS
OAHGC="N/A"

#LVM
OAHL="N/A"

#Hive
OASH="N/A"

#-----------------------------------------------------------#

#GCS
OASGC="N/A"

#LVM
OASL="N/A"

#DeleteInactive same for SGP & HKG
OASD=`echo $OAHD1 | awk '{print $2}'`

#CBM
OASC1=$(mysql -h $APACOFT_dbhost -u $APACOFT_dbusername -p$APACOFT_dbpassword -e "use scheduler; select status from runbook_instance where startedat LIKE '$dat%' and runbookid=202 ORDER BY endat DESC LIMIT 1;")
echo "Fetching Data for APAC-OFT-SGP 202"
OASC=`echo $OASC1 | awk '{print $2}'`

#Reporting
OASR1=$(mysql -h $APACOFT_dbhost -u $APACOFT_dbusername -p$APACOFT_dbpassword -e "use scheduler; select status from runbook_instance where startedat LIKE '$dat%' and runbookid=206 ORDER BY endat DESC LIMIT 1;")
echo "Fetching Data for APAC-OFT-SGP 206"
OASR=`echo $OASR1 | awk '{print $2}'`

#G3MS
OASG1=$(mysql -h $APACOFT_dbhost -u $APACOFT_dbusername -p$APACOFT_dbpassword -e "use scheduler; select status from runbook_instance where startedat LIKE '$dat%' and runbookid=205 ORDER BY endat DESC LIMIT 1;")
echo "Fetching Data for APAC-OFT-SGP 205"
OASG=`echo $OASG1 | awk '{print $2}'`

#Callback
OASCB1=$(mysql -h $APACOFT_dbhost -u $APACOFT_dbusername -p$APACOFT_dbpassword -e "use scheduler; select status from runbook_instance where startedat LIKE '$dat%' and runbookid=210 ORDER BY endat DESC LIMIT 1;")
echo "Fetching Data for APAC-OFT-SGP 210"
OASCB=`echo $OASCB1 | awk '{print $2}'`


#--------------------------APAC-OFT------------------------------------------------------#

#--------------------------EMEA-OFT------------------------------------------------------#

EMEAOFT_dbhost=""
EMEAOFT_dbusername=""
EMEAOFT_dbpassword=""

#CBM
OEFC1=$(mysql -h $EMEAOFT_dbhost -u $EMEAOFT_dbusername --ssl -p$EMEAOFT_dbpassword -e "use scheduler; select status from runbook_instance where startedat LIKE '$dat%' and runbookid=402 ORDER BY endat DESC LIMIT 1;")
echo "Fetching Data for EMEA-OFT-FRA 402"
OEFC=`echo $OEFC1 | awk '{print $2}'`

#Reporting
OEFR1=$(mysql -h $EMEAOFT_dbhost -u $EMEAOFT_dbusername --ssl -p$EMEAOFT_dbpassword -e "use scheduler; select status from runbook_instance where startedat LIKE '$dat%' and runbookid=406 ORDER BY endat DESC LIMIT 1;")
echo "Fetching Data for EMEA-OFT-FRA 406"
OEFR=`echo $OEFR1 | awk '{print $2}'`

#HIVE
OEFH1=$(mysql -h $EMEAOFT_dbhost -u $EMEAOFT_dbusername --ssl -p$EMEAOFT_dbpassword -e "use scheduler; select status from runbook_instance where startedat LIKE '$dat%' and runbookid=409 ORDER BY endat DESC LIMIT 1;")
echo "Fetching Data for EMEA-OFT-FRA 409"
OEFH=`echo $OEFH1 | awk '{print $2}'`

#Callback
OEFCB1=$(mysql -h $EMEAOFT_dbhost -u $EMEAOFT_dbusername --ssl -p$EMEAOFT_dbpassword -e "use scheduler; select status from runbook_instance where startedat LIKE '$dat%' and runbookid=410 ORDER BY endat DESC LIMIT 1;")
echo "Fetching Data for EMEA-OFT-FRA 410"
OEFCB=`echo $OEFCB1 | awk '{print $2}'`

#DeleteInactive
OEFD1=$(mysql -h $EMEAOFT_dbhost -u $EMEAOFT_dbusername --ssl -p$EMEAOFT_dbpassword -e "use scheduler; select status from runbook_instance where startedat LIKE '$dat%' and runbookid=411 ORDER BY endat DESC LIMIT 1;")
echo "Fetching Data for EMEA-OFT-FRA 411"
OEFD=`echo $OEFD1 | awk '{print $2}'`

#G3MS
OEFG="N/A"

#GCS
OEFGC="N/A"

#LVM
OEFL="N/A"
#-----------------------------------------------------------#

#CBM
OEAC1=$(mysql -h $EMEAOFT_dbhost -u $EMEAOFT_dbusername --ssl -p$EMEAOFT_dbpassword -e "use scheduler; select status from runbook_instance where startedat LIKE '$dat%' and runbookid=2 ORDER BY endat DESC LIMIT 1;")
echo "Fetching Data for EMEA-OFT-AUT 2"
OEAC=`echo $OEAC1 | awk '{print $2}'`

#Reporting
OEAR1=$(mysql -h $EMEAOFT_dbhost -u $EMEAOFT_dbusername --ssl -p$EMEAOFT_dbpassword -e "use scheduler; select status from runbook_instance where startedat LIKE '$dat%' and runbookid=6 ORDER BY endat DESC LIMIT 1;")
echo "Fetching Data for EMEA-OFT-AUT 6"
OEAR=`echo $OEAR1 | awk '{print $2}'`

#HIVE
OEAH="N/A"

#G3MS
OEAG="N/A"

#Callback
OEACB="N/A"

#GCS
OEAGC="N/A"

#LVM
OEAL="N/A"

#DeleteInactive Same for AUT & FRA
OEAD=`echo $OEFD1 | awk '{print $2}'`

#--------------------------EMEA-OFT------------------------------------------------------#

#--------------------------CHN-OFT------------------------------------------------------#

CHNOFT_dbhost=""
CHNOFT_dbusername=""
CHNOFT_dbpassword=""

#CBM
OCCC1=$(mysql -h $CHNOFT_dbhost -u $CHNOFT_dbusername -p$CHNOFT_dbpassword -e "use scheduler; select status from runbook_instance where startedat LIKE '$dat%' and runbookid=302 ORDER BY endat DESC LIMIT 1;")
echo "Fetching Data for CHN-OFT 302"
OCCC=`echo $OCCC1 | awk '{print $2}'`

#Reporting
OCCR1=$(mysql -h $CHNOFT_dbhost -u $CHNOFT_dbusername -p$CHNOFT_dbpassword -e "use scheduler; select status from runbook_instance where startedat LIKE '$dat%' and runbookid=306 ORDER BY endat DESC LIMIT 1;")
echo "Fetching Data for CHN-OFT 306"
OCCR=`echo $OCCR1 | awk '{print $2}'`

#Callback
OCCCB1=$(mysql -h $CHNOFT_dbhost -u $CHNOFT_dbusername -p$CHNOFT_dbpassword -e "use scheduler; select status from runbook_instance where startedat LIKE '$dat%' and runbookid=310 ORDER BY endat DESC LIMIT 1;")
echo "Fetching Data for CHN-OFT 310"
OCCCB=`echo $OCCCB1 | awk '{print $2}'`

#DeleteInactive
OCCD1=$(mysql -h $CHNOFT_dbhost -u $CHNOFT_dbusername -p$CHNOFT_dbpassword -e "use scheduler; select status from runbook_instance where startedat LIKE '$dat%' and runbookid=311 ORDER BY endat DESC LIMIT 1;")
echo "Fetching Data for CHN-OFT 311"
OCCD=`echo $OCCD1 | awk '{print $2}'`

#HIVE
OCCH1=$(mysql -h $CHNOFT_dbhost -u $CHNOFT_dbusername -p$CHNOFT_dbpassword -e "use scheduler; select status from runbook_instance where startedat LIKE '$dat%' and runbookid=309 ORDER BY endat DESC LIMIT 1;")
echo "Fetching Data for CHN-OFT 309"
OCCH=`echo $OCCH1 | awk '{print $2}'`

#G3MS
OCCG1=$(mysql -h $CHNOFT_dbhost -u $CHNOFT_dbusername -p$CHNOFT_dbpassword -e "use scheduler; select status from runbook_instance where startedat LIKE '$dat%' and runbookid=305 ORDER BY endat DESC LIMIT 1;")
echo "Fetching Data for CHN-OFT 305"
OCCG=`echo $OCCG1 | awk '{print $2}'`

#GCS
OCCGC="N/A"

#LVM
OCCL="N/A"

#--------------------------CHN-OFT------------------------------------------------------#

echo "Sending a mail"

curl https://api.sendgrid.com/api/mail.send.json \
        -F to=$EMAIL_TO -F subject=$SUBJECT \
        -F text="PipelineReporting" --form-string html="<html>
<head>
<style>
table, th, td {
  border: 2px solid black;
  border-collapse: collapse;
}
th, td {
  padding: 5px;
}
th {
  text-align: center;
  font-size: 13pt;
  font-weight: bold;
}
td {
  text-align: center;
}
</style>
</head>
<body>
<h1>Status Report for Data Pipeline - $dat</h1>
<table border="1">
  <tr bgcolor="skyblue">
    <th>Environment</th>
    <th>Region</th> 
    <th>Country</th>
	<th>CBM Batch</th>
	<th>Reporting</th>
	<th>HIVE API</th>
	<th>G3MS Batch</th>
	<th>Callback</th>
	<th>GCS</th>
	<th>LVM</th>
	<th>Delete Inactive Instances</th>
	</tr>
  <tr>
    <td>OFT</td>
    <td>APAC</td>
    <td>SGP</td>
	<td>$OASC</td>
	<td>$OASR</td>
	<td>$OASH</td>
	<td>$OASG</td>
	<td>$OASCB</td>
	<td>$OASGC</td>
	<td>$OASL</td>
	<td>$OASD</td>
  </tr>
  <tr>
    <td>OFT</td>
    <td>APAC</td>
    <td>HKG</td>
	<td>$OAHC</td>
	<td>$OAHR</td>
	<td>$OAHH</td>
	<td>$OAHG</td>
	<td>$OAHCB</td>
	<td>$OAHGC</td>
	<td>$OAHL</td>
	<td>$OAHD</td>
  </tr>
  <tr>
    <td>OFT</td>
    <td>EMEA</td>
    <td>FRA</td>
	<td>$OEFC</td>
	<td>$OEFR</td>
	<td>$OEFH</td>
	<td>$OEFG</td>
	<td>$OEFCB</td>
	<td>$OEFGC</td>
	<td>$OEFL</td>
	<td>$OEFD</td>
  </tr>
  <tr>
    <td>OFT</td>
    <td>EMEA</td>
    <td>AUT</td>
	<td>$OEAC</td>
	<td>$OEAR</td>
	<td>$OEAH</td>
	<td>$OEAG</td>
	<td>$OEACB</td>
	<td>$OEAGC</td>
	<td>$OEAL</td>
	<td>$OEAD</td>
  </tr>
  <tr>
    <td>OFT</td>
    <td>NAA</td>
    <td>NAA</td>
	<td>$ONNC</td>
	<td>$ONNR</td>
	<td>$ONNH</td>
	<td>$ONNG</td>
	<td>$ONNCB</td>
	<td>$ONNGC</td>
	<td>$ONNL</td>
	<td>$ONND</td>
  </tr>
  <tr>
    <td>OFT</td>
    <td>CHINA</td>
    <td>CHINA</td>
	<td>$OCCC</td>
	<td>$OCCR</td>
	<td>$OCCH</td>
	<td>$OCCG</td>
	<td>$OCCCB</td>
	<td>$OCCGC</td>
	<td>$OCCL</td>
	<td>$OCCD</td>
  </tr>
  <tr>
    <td>Stage</td>
    <td>NAA</td>
    <td>NAA</td>
	<td>$SNNC</td>
	<td>$SNNR</td>
	<td>$SNNH</td>
	<td>$SNNG</td>
	<td>$SNNCB</td>
	<td>$SNNGC</td>
	<td>$SNNL</td>
	<td>$SNND</td>
  </tr>
  <tr>
    <td>Stage</td>
    <td>EMEA</td>
    <td>FRA</td>
	<td>$SEFC</td>
	<td>$SEFR</td>
	<td>$SEFH</td>
	<td>$SEFG</td>
	<td>$SEFCB</td>
	<td>$SEFGC</td>
	<td>$SEFL</td>
	<td>$SEFD</td>
  </tr>
  <tr>
    <td>Prod</td>
    <td>NAA</td>
    <td>NAA</td>
	<td>$PNNC</td>
	<td>$PNNR</td>
	<td>$PNNH</td>
	<td>$PNNG</td>
	<td>$PNNCB</td>
	<td>$PNNGC</td>
	<td>$PNNL</td>
	<td>$PNND</td>
  </tr>
  <tr>
    <td>Prod</td>
    <td>EMEA</td>
    <td>FRA</td>
	<td>$PEFC</td>
	<td>$PEFR</td>
	<td>$PEFH</td>
	<td>$PEFG</td>
	<td>$PEFCB</td>
	<td>$PEFGC</td>
	<td>$PEFL</td>
	<td>$PEFD</td>
  </tr>
</table>
</body>
</html>" \
        -F from=$FROM_EMAIL -F api_user=$SENDGRIDAPIUSER -F api_key=$SENDGRIDAPIPASSWORD
