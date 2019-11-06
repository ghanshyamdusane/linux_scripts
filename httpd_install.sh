#!/bin/sh
echo "Updating packages ..."
sudo yum -y install httpd
whoami > /tmp/whoami
pwd > /tmp/pwd
