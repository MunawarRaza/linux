#!/bin/bash
Intellicon_config() {
echo '########################################'
echo '####     configuring Intellicon     ####'
echo '########################################'
echo
echo
mkdir /home/backup-$(date +"%d-%m-%Y")
cd /home/backup-$(date +"%d-%m-%Y")
echo
pwd
sleep 2
cp /root/app/gitprectice/file1  /home/backup-$(date +"%d-%m-%Y")
echo
echo
hostname=$(cat /etc/hostname)
echo
echo $hostname
echo
sleep 2
sed -i "s/\$config\['base_url'\]     \= ''/\$config\['base_url'\]     \= 'https:\/\/$hostname\/intellicon\/'/g"  /home/backup-$(date +"%d-%m-%Y")/file1
echo
cat file1
echo '##### DONE ####'
}

Intellicon_config