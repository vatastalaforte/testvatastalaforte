#!/bin/bash
#
# author : Vito Amoroso
# date   : 28-Nov-2016
# name   : start.sh
# version: 1.0.0
#
# history
# - 2016-11-28 : first release
#=============================================================================
#
# NOTE:
#
# sys variables
#set -x
export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/bin/X11:/usr/local/sbin:/usr/local/bin
LOG="/$HOME/log_`date "+%Y-%m-%d_%H%M%S"`_.log"
ERRMSG="/$HOME/err_mgs_`date "+%Y-%m-%d_%H%M%S"`_.log"

echo "Hello, please input your eth interface name: (verify with ifconfig)"
read ethadapter

echo "WELCOME ON THE INSTALLATION OF YOUR WORDPRESS VIRTUAL MACHINE!!!"
echo "NOW THE INSTALLATION WILL START, TAKE A COFFEE AND BE PATIENT..."

sudo apt-add-repository "deb http://download.virtualbox.org/virtualbox/debian vivid contrib" >/dev/null
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
sudo apt-get update -y >/dev/null

# Get the iso image from the central repo
if [ -f /$HOME/WordpressUbuntuWithMySQL.tar ]; then
    echo "The OS image is present on your Home"
    echo "`date "+%Y-%m-%d_%H%M%S"`_The OS image is present on you Home, going to extract..." > $LOG
    tar -zxvf /$HOME/WordpressUbuntuWithMySQL.tar
else
    echo "The OS image is NOT present on your Home, going to download It and extract..."
    echo "`date "+%Y-%m-%d_%H%M%S"`_The OS image is NOT present on you Home, going to download It and extract..." >> $LOG
    wget -O /$HOME/WordpressUbuntuWithMySQL.tar https://www.dropbox.com/s/2nzns9mt5icmans/WordpressUbuntuWithMySQL.tar?dl=0
    tar -zxvf /$HOME/WordpressUbuntuWithMySQL.tar
fi

# Install Virtualbox
if which virtualbox >/dev/null; then
    echo "Virtualbox already installed"
    echo "`date "+%Y-%m-%d_%H%M%S"`_Virtualbox already installed..." >> $LOG
else
echo "Installing Virtualbox..."
echo "`date "+%Y-%m-%d_%H%M%S"`_Installing Virtualbox..." >> $LOG
echo "---------------------" >> $LOG
sudo apt-get install virtualbox-5.0 -y | tee /tmp/virtualbox_error 
EXIT_CODE=$?
if [ $EXIT_CODE -ne 0 ]; then
    echo "`date "+%Y-%m-%d_%H%M%S"`_ An error occurred while installing Virtualbox" >> $ERRMSG
    cat /tmp/virtualbox_error >> $ERRMSG
	exit 1
	fi
fi

# Install DKMS
if which dkms >/dev/null; then
    echo "Dkms already installed"
    echo "`date "+%Y-%m-%d_%H%M%S"`_Dkms already installed..." >> $LOG
else
echo "Installing Dkms..."
echo "`date "+%Y-%m-%d_%H%M%S"`_Installing Dkms..." >> $LOG
echo "---------------------" >> $LOG
sudo apt-get install dkms -y
if [ $? -ne 0 ]; then
    echo "`date "+%Y-%m-%d_%H%M%S"`_ An error occurred while installing dkms" >> $ERRMSG
	exit 1
	fi
fi

# Install SSHPass
if which sshpass >/dev/null; then
    echo "SSHPass already installed"
    echo "`date "+%Y-%m-%d_%H%M%S"`_SSHPass already installed..." >> $LOG
else
echo "Installing SSHPass..."
echo "`date "+%Y-%m-%d_%H%M%S"`_Installing SSHPass..." >> $LOG
echo "---------------------" >> $LOG
sudo apt-get install sshpass >> $LOG
if [ $? -ne 0 ]; then
    echo "`date "+%Y-%m-%d_%H%M%S"`_ An error occurred while installing sshpass" >> $ERRMSG
    echo $? >> $ERRMSG
	exit 1
	fi
fi

# Configuration of the Virtual Machine
VM='WordpressUbuntu_final'
VBoxManage createhd --filename $VM.vdi --size 16000
VBoxManage createvm --name $VM --ostype 'Ubuntu_64' --register
VBoxManage modifyvm $VM --cpus 4

VBoxManage storagectl $VM --name "SATA Controller" --add sata --controller IntelAHCI
#VBoxManage storageattach $VM --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium $VM.vdi
VBoxManage storageattach $VM --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium /$HOME/WordpressUbuntuWithMySQL.vdi

#VBoxManage storagectl $VM --name "IDE Controller" --add ide
#VBoxManage storageattach $VM --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium /home/ubuntu-auto.iso

VBoxManage modifyvm $VM --ioapic on
VBoxManage modifyvm $VM --boot1 dvd --boot2 disk --boot3 none --boot4 none
VBoxManage modifyvm $VM --memory 2048 --vram 16
VBoxManage modifyvm $VM --nic1 bridged --nictype1 82540EM --bridgeadapter1 $ethadapter
#VBoxManage modifyvm $VM --nic1 nat --nictype1 82540EM --cableconnected1 on
VBoxManage startvm $VM --type gui
#sudo VBoxHeadless -s $VM
if [ $? -ne 0 ]; then
    echo "`date "+%Y-%m-%d_%H%M%S"`_ An error occurred with VBoxManage" >> $ERRMSG
    echo $? >> $ERRMSG
fi

# The following code is needed to obtain the MAC address of the machine
# Get a string of the form macaddress1=xxxxxxxxxxx
var1=$(VBoxManage showvminfo $VM --machinereadable |grep macaddress1)
# Asdign macaddress1 the MAC address as a value
eval $var1
# Assign m the MAC address in lower case
m=$(echo ${macaddress1}|tr '[A-Z]' '[a-z]')
# This is the MAC address formatted with : and 0n translated into n
mymac=$(echo `expr ${m:0:2}`:`expr ${m:2:2}`:`expr ${m:4:2}`:`expr ${m:6:2}`:`expr ${m:8:2}`:`expr ${m:10:2}`)
echo "The MAC address of the virtual machine $1 is $mymac"
if [ $? -ne 0 ]; then
    echo "`date "+%Y-%m-%d_%H%M%S"`_ An error occurred while looking for the MAC address" >> $ERRMSG
    exit 1
fi

# Wait 30 secs...
# Until $(VBoxManage showvminfo --machinereadable $VM | grep -q ^VMState=.poweroff.)
#do
  echo "Installation will continue soon, the machine is going to boot..."
  sleep 30
#done

# Execute an arp-scan to match mac address and obtain the machine IP
sudo arp-scan --interface=$ethadapter --localnet | awk '{print $1" "$2" "$3}' > /tmp/list-interface.tmp
while IFS=" " read -r ip mac desc
do 
  if [ "$mac" = "$mymac" ]; then 
    ip_final=$ip
    echo "the IP address is $ip"
  fi
done < /tmp/list-interface.tmp
if [ $? -ne 0 ]; then
    echo "`date "+%Y-%m-%d_%H%M%S"`_ An error occurred looking for the IP address" >> $ERRMSG
    exit 1
fi

# Start the installation of Apache2, PHP5 and Wordpress
sshpass -p 'wordpress2016' ssh -o "StrictHostKeyChecking no" wordpress@$ip_final "bash -s" <./installPackages.sh

echo "PLEASE INSERT yes AND USER PASSWORD USEFUL TO SET DB CONFIGURATION FOR WORDPRESS"
sudo scp /$HOME/wp-config.php /$HOME/setup-wordpress.sh wordpress@$ip_final:/var/www/html/
#sudo scp /$HOME/setup-wordpress.sh wordpress@$ip_final:/var/www/html/wp-admin/setup-wordpress.sh

sshpass -p 'wordpress2016' ssh -o "StrictHostKeyChecking no" wordpress@$ip_final "bash -s" <./start-wordpress-setup.sh

#sudo mysql -u root -pwordpress16 -e "CREATE DATABASE wordpress; CREATE USER wordpressuser@localhost IDENTIFIED BY 'wordpress2016'; GRANT ALL PRIVILEGES ON wordpress.* TO wordpressuser@localhost; FLUSH PRIVILEGES;"

echo "INSTALLATION COMPLETED, PLEASE VISIT HTTP://$ip_final and enjoy youw Wordpress installation!!!"
echo "`date "+%Y-%m-%d_%H%M%S"`_INSTALLATION COMPLETED, PLEASE VISIT HTTP://$ip_final and enjoy youw Wordpress installation!!!" >> $LOG
