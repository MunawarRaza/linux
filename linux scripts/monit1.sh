#!/bin/bash
#yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
#yum -y install monit

echo '##########################################'
echo '###        Monit Installation          ###'
echo '##########################################'

#INTERFACES=$(ip a | grep "state UP" |awk '{print $2}' |cut -d':' -f1)

#IPs=$(ip a|grep "mtu" |awk '{print $2}' |cut -d':' -f1)
MAINDIAR=/root/monit-script/cx9monit/
LOCALPAT=/var/local/
MONITDIR=/etc/monit.d/

function clone_monit(){
        echo "I am in clone_monit function"
        sleep 2
#git clone  https://github.com/MunawarRaza/monit-script.git
#unzip /root/monit-script/cx9monit.zip
mv ${MAINDIAR}*.sh  $LOCALPAT
chmod 777 ${LOCALPAT}/*
mv ${MAINDIAR}/* $MONITDIR
}

function add_interface(){
        echo "I am in add_interface function"
        sleep 2
for i in $(ip a|grep "state UP" |awk '{print $2}' |cut -d':' -f1)
do
#echo "Welcome ${i} heeelo ${i}" >>/root/script/file
echo '#Network interface '${i}' 
check network '${i}' with interface '${i}'
  start program = "'/sbin/ifup ${i}'"
  stop program = "'/sbin/ifdown ${i}'"
  if failed link then restart
  if failed link then alert
  if changed link then alert' >>${MONITDIR}/cx9_system
done
}

function start_monit(){
        echo "I am in start_monit function"
        sleep 2
#monit reload
systemctl enable monit
systemctl start monit
systemctl status monit
sleep 5
monit status

}
#mv /root/cx9monit/mail_template /etc/monit.d/
#mv /root/cx9monit/alert_email /etc/monit.d/
#mv /root/cx9monit/cx9_system  /etc/monit.d
#mv /root/cx9monit/http_settings /etc/monit.d/
#mv /root/cx9monit/set_mail /etc/monit.d/
#firewall-cmd --add-port=28121/tcp --permanent
#firewall-cmd --reload

#monit status
#systemctl restart monit
#monit status
#sleep 5

clone_monit
add_interface
start_monit