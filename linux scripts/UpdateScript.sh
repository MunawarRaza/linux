#!/bin/bash

CONFIG_PHP=/var/www/html/intellicon/application/config/config.php
AJAM=/var/www/html/intellicon/application/config/yovo_ajam.php
CONFIG_JSON=/etc/node/config/config.json
KEY=/etc/node/config/key.lic
PUBLIC=/etc/node/config/public.pem
INDEX_JS=/root/cx9/cx9-servers/config/index.js
ENV=/root/cx9/cx9-servers/cx9-migrations/.env
INTELLICON=/var/www/html/intellicon/

mkdir /home/backup-$(date +"%d-%m-%Y")
BACKUP=/home/backup-$(date +"%d-%m-%Y")

function files_backup() {
echo '########################################'
echo '####       Taking backuo            ####'
echo '########################################'
echo
echo
#mkdir /home/backup-$(date +"%d-%m-%Y")
#cp /var/www/html/intellicon/application/config/config.php /home/backup-$(date +"%d-%m-%Y")/
#cp /var/www/html/intellicon/application/config/yovo_ajam.php /home/backup-$(date +"%d-%m-%Y")/
#cp /etc/node/config/config.json /home/backup-$(date +"%d-%m-%Y")/
#cp /etc/node/config/key.lic /home/backup-$(date +"%d-%m-%Y")/
#cp /etc/node/config/public.pem /home/backup-$(date +"%d-%m-%Y")/
#cp /root/cx9/cx9-servers/config/index.js /home/backup-$(date +"%d-%m-%Y")/
#cp /root/cx9/cx9-servers/cx9-migrations/.env /home/backup-$(date +"%d-%m-%Y")/

cp $CONFIG_PHP $BACKUP
cp $AJAM $BACKUP
cp $CONFIG_JSON $BACKUP
cp $KEY $BACKUP
cp $PUBLIC $BACKUP
cp $INDEX_JS $BACKUP
cp $ENV $BACKUP
echo
echo
echo '###  files backup has been taken ###'
echo
echo
}
git_pull_Admin() {
echo '########################################'
echo '####       Pulling Admin Side       ####'
echo '########################################'
echo
echo
cd /var/www/html/intellicon/
git pull |& tee result.text
a=$(grep -i "Aborting" result.text);
echo 'Your Error:' $a
if [ "$a"==Aborting ]; then
        {
echo '########################################'
echo '####     You have local changes     ####'
echo '########################################'
        cd /var/www/html/intellicon/ 
        git checkout .
        git pull |& tee final.text
echo '############ Admin Side pull is done ############'
        }
else {
echo '############ Git pull for Admin side is done ############'
   }
fi
}
git_pull_cx9Server() {
echo '########################################'
echo '####       Pulling CX9 Servers      ####'
echo '########################################'
echo
echo
cd /root/cx9/cx9-servers/
git pull |& tee result.text
b=$(grep -i "Aborting" result.text);
echo 'Your Error:' $b
if [ "$b"==Aborting ]; then
        {
echo '########################################'
echo '####     You have local changes     ####'
echo '########################################'
        cd /root/cx9/cx9-servers/ 
        git checkout .
        git pull |& tee final.text
echo '############ CX9 Servers pull is done ############'
        }
else {
echo '############ Git pull for CX9 Servers is done ############'
   }
fi
}
git_pull_Node() {
echo '########################################'
echo '####       Pulling Node             ####'
echo '########################################'
echo
echo
cd /etc/node/
git pull |& tee result.text
b=$(grep -i "Aborting" result.text);
echo 'Your Error:' $b
if [ "$b"==Aborting ]; then
        {
echo '########################################'
echo '####     You have local changes     ####'
echo '########################################'
        cd /etc/node/ 
        git checkout .
        git pull |& tee final.text
echo '############ Node pull is done ############'
        }
else {
echo '############ Git pull for Node is done ############'
   }
fi
}


Intellicon_config() {
echo '########################################'
echo '####     configuring Intellicon     ####'
echo '########################################'
echo
echo
hostname=$(cat /etc/hostname)
echo $hostname
sleep 2
sed -i "s/\$config\['base_url'\]     \= ''/\$config\['base_url'\]     \= 'https:\/\/$hostname\/intellicon\/'/g" /var/www/html/intellicon/application/config/config.php
#/var/www/html/intellicon/application/config/yovo_ajam.php
#sed "s/'urlraw' => 'http:\/\/ast14.contegris.com:8088\/intelli-Ajam\/rawman'/'urlraw' => 'http:\/\/$hostname.contegris.com:8088\/intelli-Ajam\/rawman'/g" /var/www/html/intellicon/application/config/yovo_ajam.php
#sed "s/'urlxml' => 'http:\/\/ast14.contegris.com:8088\/intelli-Ajam\/mxml'/'urlxml' => 'http:\/\/$hostname.contegris.com:8088\/intelli-Ajam\/mxml'/g" /var/www/html/intellicon/application/config/yovo_ajam.php
sed -i "s/'urlraw' => 'http:\/\/ast14.contegris.com:8088\/intelli-Ajam\/rawman'/'urlraw' => 'http:\/\/$hostname:8088\/intelli-Ajam\/rawman'/g" /var/www/html/intellicon/application/config/yovo_ajam.php
sed -i "s/'urlxml' => 'http:\/\/ast14.contegris.com:8088\/intelli-Ajam\/mxml'/'urlxml' => 'http:\/\/$hostname:8088\/intelli-Ajam\/mxml'/g" /var/www/html/intellicon/application/config/yovo_ajam.php
chmod -R 755 /var/www/html/intellicon/
chown -R apache:apache /var/www/html/intellicon/
echo '##### Admin configurations are done ####'
}

cx9servers_config() {
echo '########################################'
echo '####     configuring cx9 Server     ####'
echo '########################################'
echo
echo
hostname=$(cat /etc/hostname)
echo $hostname
sleep 2
sed -i 's|const DOMAIN_URL = ""|const DOMAIN_URL = "'$hostname'"|g' /root/cx9/cx9-servers/config/index.js
token=$(cat /home/backup-$(date +"%d-%m-%Y")/index.js |grep FB_AC |awk '{print $4}') 
echo $token
echo
sed -i "s/const FB_ACCESS_TOKEN = ''/const FB_ACCESS_TOKEN = $token/" /root/cx9/cx9-servers/config/index.js
cd /root/cx9/cx9-servers/ 
node install.js
echo '##### Admin configurations are done ####'
}



function git_pull() {
cd /root/app/gitprectice/
git pull |& tee result.text
a=$(grep -i "Aborting" result.text);
echo 'Your error:' $a
if [ "$a" == Aborting ]; then
        {
echo '############# I am In IF statement #############'
sleep 5
cd /root/app/gitprectice/ 
git checkout .
git pull |& tee final.text
        }
else {
echo '############# I am In ELSE statement #############'
sleep 10
        echo "your code is updated"
   }
   fi
}



#function git_pull() {
#cd /root/app/gitprectice/
#git pull |& tee result.text
#aborting=$(grep -i "Aborting" result.text);
#if [ $aborting=='Aborting' ]; then
#       {
#cd /root/app/gitprectice/ 
#git checkout .
#git pull
#       }
#else {
#       echo "your code is updated"
#   }
#   fi
#}



#files_backup
#git_pull
#git_pull_Admin()
#git_pull_cx9Server()
#git_pull_Node()
Intellicon_config
