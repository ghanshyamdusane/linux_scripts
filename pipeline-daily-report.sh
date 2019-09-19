#!/bin/bash
#Author and Maintained by : Ghanshyam Dusane
#Variables

SENDGRIDAPIUSER=""
SENDGRIDAPIPASSWORD=""
EMAIL_TO=""
FROM_EMAIL=""
FROM_NAME=""
dat=`date +%F`
SUBJECT="Pipeline-Report-$dat"


#--------------------------NAA-OFT------------------------------------------------------#

NAAOFT_dbhost=""
NAAOFT_dbusername=""
NAAOFT_dbpassword=""

ONNH="N/A"
ONNG="N/A"

ONNC1=$(mysql -h $NAAOFT_dbhost -u $NAAOFT_dbusername -p$NAAOFT_dbpassword -e "use scheduler; select status from runbook_instance where startedat LIKE '$dat%' and runbookid=602 ORDER BY endat DESC LIMIT 1;")
echo "Fetching Data for NAA-OFT 602"
ONNC=`echo $ONNC1 | awk '{print $2}'`

ONNR1=$(mysql -h $NAAOFT_dbhost -u $NAAOFT_dbusername -p$NAAOFT_dbpassword -e "use scheduler; select status from runbook_instance where startedat LIKE '$dat%' and runbookid=606 ORDER BY endat DESC LIMIT 1;")
echo "Fetching Data for NAA-OFT 606"
ONNR=`echo $ONNC1 | awk '{print $2}'`

ONNCB1=$(mysql -h $NAAOFT_dbhost -u $NAAOFT_dbusername -p$NAAOFT_dbpassword -e "use scheduler; select status from runbook_instance where startedat LIKE '$dat%' and runbookid=610 ORDER BY endat DESC LIMIT 1;")
echo "Fetching Data for NAA-OFT 610"
ONNCB=`echo $ONNC1 | awk '{print $2}'`

ONND1=$(mysql -h $NAAOFT_dbhost -u $NAAOFT_dbusername -p$NAAOFT_dbpassword -e "use scheduler; select status from runbook_instance where startedat LIKE '$dat%' and runbookid=611 ORDER BY endat DESC LIMIT 1;")
echo "Fetching Data for NAA-OFT 611"
ONND=`echo $ONNC1 | awk '{print $2}'`

ONNGC1=$(mysql -h $NAAOFT_dbhost -u $NAAOFT_dbusername -p$NAAOFT_dbpassword -e "use scheduler; select status from runbook_instance where startedat LIKE '$dat%' and runbookid=613 ORDER BY endat DESC LIMIT 1;")
echo "Fetching Data for NAA-OFT 613"
ONNGC=`echo $ONNC1 | awk '{print $2}'`

ONNL1=$(mysql -h $NAAOFT_dbhost -u $NAAOFT_dbusername -p$NAAOFT_dbpassword -e "use scheduler; select status from runbook_instance where startedat LIKE '$dat%' and runbookid=614 ORDER BY endat DESC LIMIT 1;")
echo "Fetching Data for NAA-OFT 614"
ONNL=`echo $ONNC1 | awk '{print $2}'`

#--------------------------NAA-OFT------------------------------------------------------#

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
}
td {
  text-align: center;
}
</style>
</head>
<body>
<h2>Status Report for Data Pipelines - $dat</h2>
                <table style="width:100%">
  <tr>
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
