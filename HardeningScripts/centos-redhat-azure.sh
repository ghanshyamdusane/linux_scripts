#!/bin/bash
#Author & Maintained by : Ghanshyam Dusane
#Password Length 8 Character
#Password Complexity ( Upper case/Lower Case/Number/Non-alphanumeric characters, (!, @, #, $, etc.) 
#Passwords remembered must be set to at least five (5). 
#Systems must be configured to “lockout” after ten (maximum) wrong password entries and shall not automatically unlock for at least one hour.
#For user accounts with elevated privileges and where technically feasible, the screensaver lockout or re-authentication requirement must be set to 15 minutes.
#Exclude the patches while patching
if [[ $EUID -ne 0 ]]; then
        echo "This script must be run as root"
        exit 0
fi
	echo "***************stop and disable the Firewall***************"
		service firewalld stop
		#service iptables stop
		systemctl disable firewalld
		#chkconfig iptables off
	sleep 5
	echo "Backup of selinux config file"
		cp -iv /etc/selinux/config /etc/selinux/config-bkp-$(date +%Y%m%d-%H:%M)
	echo "disabiling the selinux"
		sed -i "s/SELINUX=enforcing/SELINUX=disabled/" /etc/selinux/config
	echo "Changes Done"
	sleep 5
	echo "See the SELUNUX Config file content"
		cat /etc/selinux/config
	
	echo "***************Backup SSHD Config file...***************"
	sleep 5
		cp -iv /etc/ssh/sshd_config /etc/ssh/sshd_config-bkp-$(date +%Y%m%d-%H:%M)
	sleep 5
	echo "***************Backup Completed!***************"
	sleep 5
	echo "***************Making Changes in Port No,PermitRootLogin and Banner***************"
		#sed -i "s/#Port 22/Port 2222/" /etc/ssh/sshd_config
		sed -i "s/#PermitRootLogin yes/PermitRootLogin no/" /etc/ssh/sshd_config
		sed -i '/#Banner/a Banner /etc/banner' /etc/ssh/sshd_config
	sleep 5
	echo "***************Changes Done. See the below Output***************"
		cat /etc/ssh/sshd_config | egrep "PermitRootLogin |Port |banner"
	echo "Restarting the SSH service"
	sleep 5
		service sshd restart
	echo "SSH Service restarted see the status"
	sleep 5
		service sshd status
	echo "Backing up login.def file..."
		cp -iv /etc/login.defs /etc/login.defs-bkp-$(date +%Y%m%d-%H:%M)
	sleep 5
	echo "Backup completed"
	echo "Changing the pasword policy"
	sleep 5
		sed -i "s/^PASS_MAX_DAYS.*/PASS_MAX_DAYS\   90/g" /etc/login.defs
		sed -i "s/^PASS_MIN_DAYS.*/PASS_MIN_DAYS\   1/g" /etc/login.defs
		sed -i "s/^PASS_MIN_LEN.*/PASS_MIN_LEN\    8/g" /etc/login.defs
		sed -i "s/^PASS_WARN_AGE.*/PASS_WARN_AGE\   7/g" /etc/login.defs
		sed -i '/use_authtok/ s/$/ remember=5/' /etc/pam.d/system-auth
	echo "Changes Done"
	sleep 5
	cat /etc/login.defs | grep "^PASS_"
	sleep 5
	echo "Backup bashrc file"
		cp -iv /etc/bashrc /etc/bashrc-bkp-$(date +%Y%m%d-%H:%M)
	sleep 5
	echo 'export HISTTIMEFORMAT="%d/%m/%y %T "' >> /etc/bashrc
	sleep 5
		touch /etc/banner
	echo '"Warning:  Use of this System is Restricted to Authorized Users"' >> /etc/banner
	echo "This computer system is the private property of the Company and may be used only by those individuals authorized by the Company, in accordance with Company policy.  Unauthorized, illegal or improper use may result in disciplinary action and/or civil or criminal prosecution.  Your use of Company electronic systems is subject to monitoring and disclosure in accordance with Company policy and applicable law.  By continuing to access this system, you agree that your use of Company electronic systems is subject to the foregoing and that you have no expectation of privacy in regard to any files or data stored, accessed, transmitted or received on such systems." >> /etc/banner
	sleep 5
	echo "See the Banner file content"	
		cat /etc/banner
	sleep 5
		echo "Installating the packages"
	sleep 5
		yum install sysstat audit elinks nmap wget curl unzip ntp ntpstat -y
	sleep 5
	echo "creating swap space using waagent agnet"
		cp -iv /etc/waagent.conf /etc/waagent.conf-bkp--$(date +%Y%m%d-%H:%M)
	echo "waagent conf file backup completed"
		sed -i "s/ResourceDisk.Format=n/ResourceDisk.Format=y/" /etc/waagent.conf
		sed -i "s/ResourceDisk.EnableSwap=n/ResourceDisk.EnableSwap=y/" /etc/waagent.conf
		sed -i "s/ResourceDisk.SwapSizeMB=0/ResourceDisk.SwapSizeMB=8192/" /etc/waagent.conf
	echo "Restarting WAAGNET Service"
		systemctl restart waagent.service
		systemctl status waagent.service
	echo "Backup of passwd file"
		cp -iv /etc/passwd /etc/passwd-$(date +%Y%m%d-%H:%M)
	echo "Making change"
		usermod -s /sbin/nologin root
		cat /etc/passwd | grep -i root
	echo "Creating Linux Admins Users"
		useradd -m -c "Ghansham Dusane | $(date +%m-%d-%Y)" -s /bin/bash dusangh-a
	sleep 5
	echo "Adding in Wheel Group"
		usermod -aG wheel dusangh-a
