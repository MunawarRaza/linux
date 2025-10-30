#!/bin/bash

function files_backup() {
echo '###  taking the backup of custome files  ###'
mkdir /home/backup-$(date +"%d-%m-%Y")
cp /var/www/html/intellicon/application/config/config.php /home/backup-$(date +"%d-%m-%Y")/
cp /var/www/html/intellicon/application/config/yovo_ajam.php /home/backup-$(date +"%d-%m-%Y")/
cp /etc/node/config/config.json /home/backup-$(date +"%d-%m-%Y")/
cp /etc/node/config/key.lic /home/backup-$(date +"%d-%m-%Y")/
cp /etc/node/config/public.pem /home/backup-$(date +"%d-%m-%Y")/
cp /root/cx9/cx9-servers/config/index.js /home/backup-$(date +"%d-%m-%Y")/
cp /root/cx9/cx9-servers/cx9-migrations/.env /home/backup-$(date +"%d-%m-%Y")/

echo '###  files backup has been taken ###'
echo
echo
}
git_pull_Admin() {

echo '########################################'
echo '####       Pulling Admin Side       ####'
echo '########################################'
cd /var/www/html/intellicon/
git pull |& tee result.text
aborting=$(grep -i "ror: Your local changes to the following files would be overwritten by merge" result.text);
if [ $aborting=='ror: Your local changes to the following files would be overwritten by merge' ]; then
        {
echo '########################################'
echo '####     You have local changes     ####'
echo '########################################'
        cd /var/www/html/intellicon/ 
        git checkout .
        git pull
echo '############ Git pull is done ############'
        }
else {
echo '############ Git pull is done ############'
   }
fi
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
git_pull
#git_pull_Admin()
