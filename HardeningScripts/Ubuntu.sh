#!/bin/bash
#Author and Mainatained By : Ghanshyam Dusane
#Password Length 8 Character
#Password Complexity ( Upper case/Lower Case/Number/Non-alphanumeric characters, (!, @, #, $, etc.)
#Passwords remembered must be set to at least five (5).
#Systems must be configured to “lockout” after ten (maximum) wrong password entries and shall not automatically unlock for at least one hour.
#For user accounts with elevated privileges and where technically feasible, the screensaver lockout or re-authentication requirement must be set to 15 minutes.
#Exclude the patches while patching
if [[ $EUID -ne 0 ]]; then
        echo "This script must be run as root"
        exit 1
fi
        echo "***************stop and disable the Firewall***************"
                /etc/init.d/ufw stop
                ufw disable
        sleep 5
        echo "***************Backup SSHD Config file...***************"
        sleep 5
                cp -iv /etc/ssh/sshd_config /etc/ssh/sshd_config-bkp-$(date +%Y%m%d-%H:%M)
        sleep 5
        echo "***************Backup Completed!***************"
        sleep 5
        echo "***************Making Changes in Port No,PermitRootLogin and Banner***************"
                #sed -i "s/Port 22/Port 2222/" /etc/ssh/sshd_config
                sed -i "s/PermitRootLogin prohibit-password/PermitRootLogin no/" /etc/ssh/sshd_config
                sed -i '/#Banner/a Banner /etc/banner' /etc/ssh/sshd_config
        sleep 5
        echo "***************Changes Done. See the below Output***************"
                cat /etc/ssh/sshd_config | grep -E "PermitRootLogin |Port |Banner"
        echo "Restarting the SSH service"
        sleep 5
                service sshd restart
        echo "SSH Service restarted see the status"
        sleep 5
                service sshd status
        echo "Backing up login.def file..."
                cp -iv /etc/login.defs /etc/login.defs-bkp-$(date +%Y%m%d-%H:%M)
                cp -iv /etc/pam.d/common-password /etc/pam.d/common-password-bkp-$(date +%Y%m%d-%H:%M)
        sleep 5
        echo "Backup completed"
        echo "Changing the pasword policy"
        sleep 5
                sed -i "s/^PASS_MAX_DAYS.*/PASS_MAX_DAYS\   90/g" /etc/login.defs
                sed -i "s/^PASS_MIN_DAYS.*/PASS_MIN_DAYS\   1/g" /etc/login.defs
                sed -i "s/^PASS_WARN_AGE.*/PASS_WARN_AGE\   7/g" /etc/login.defs
                sed -i '/ignore/ s/$/ remember=5/' /etc/pam.d/common-password
                sed -i '/ignore/ s/$/ minlen=8/' /etc/pam.d/common-password
        sleep 5
        echo "Changes Done"
                cat /etc/login.defs | grep "^PASS_"
                cat /etc/pam.d/common-password | grep -E "remember|minlen"
        sleep 5
        echo "Backup bashrc file"
                cp -iv /etc/bash.bashrc /etc/bash.bashrc-bkp-$(date +%Y%m%d-%H:%M)
        sleep 5
        echo 'export HISTTIMEFORMAT="%d/%m/%y %T "' >> /etc/bash.bashrc
        sleep 5

                echo "Banner file creating and adding content"
                touch /etc/banner
                echo '"Warning:  Use of this System is Restricted to Authorized Users"' >> /etc/banner
                echo "This computer system is the private property of the Company and may be used only by those individuals authorized by the Company, in accordance with Company policy.  Unauthorized, illegal or improper use may result in disciplinary action and/or civil or criminal prosecution.  Your use of Company electronic systems is subject to monitoring and disclosure in accordance with Company policy and applicable law.  By continuing to access this system, you agree that your use of Company electronic systems is subject to the foregoing and that you have no expectation of privacy in regard to any files or data stored, accessed, transmitted or received on such systems." >> /etc/banner
                sleep 5
                cat /etc/banner
                sleep 5
        echo "***************Disable Ctrl+Alt+Delete***************"
                systemctl mask ctrl-alt-del.target
                systemctl daemon-reload
        echo "***************Package Installation**************"
                apt-get install apt -y ; apt-get install curl -y ; apt-get install unzip -y ; apt-get install tar -y ; apt-get install wget -y

        echo "Swap Space changes going on"
                cp -iv /etc/waagent.conf /etc/waagent.conf-$(date +%Y%m%d-%H:%M)
                sed -i "s/ResourceDisk.Format=n/ResourceDisk.Format=y/" /etc/waagent.conf
                sed -i "s/ResourceDisk.EnableSwap=n/ResourceDisk.EnableSwap=y/" /etc/waagent.conf
                sed -i "s/ResourceDisk.SwapSizeMB=0/ResourceDisk.SwapSizeMB=8192/" /etc/waagent.conf
        echo "WAAgent service restarting"
                service walinuxagent restart
        sleep 5
        echo "NTP Status"
                apt-get install ntp -y ; apt-get install ntpstat -y
                timedatectl status
                timedatectl set-ntp true
                service ntp restart
                timedatectl status
                ntpq -p
        sleep 5
        echo "service audit starting"
                apt-get install auditd -y
                service auditd status
                service auditd start
                service auditd status
        sleep 5
        echo "Changing root shell"
        echo "Backup of passwd file"
                cp -iv /etc/passwd /etc/passwd-$(date +%Y%m%d-%H:%M)
        echo "Making change"
                usermod -s /usr/sbin/nologin root
                cat /etc/passwd | grep -i root
        sleep 5
        echo "SAR command installation"
                apt-get install sysstat -y
                sed -i "s/false/true/" /etc/default/sysstat
                service sysstat restart
        echo "Creating Linux Admins Users"
        useradd -m -c "Ghansham Dusane Linux Admin | $(date +%m-%d-%Y)" -s /bin/bash mahajag-a
        usermod -aG sudo dusangh-a
        #timedatectl set-timezone America/New_York
