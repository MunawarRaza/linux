#!/bin/bash

#INTERFACES='1,2,3'
#i=1
DISK=$(df -h |grep "G" |cut -d"G" -f1 |awk '{if ($2 >=10) 'print $1' ')
echo ${DISK}
#for i in $(ip a|grep "state UP" |awk '{print $2}' |cut -d':' -f1)
#do
##echo "Welcome ${i} heeelo ${i}" >>/root/script/file
#echo "#Network interface ${i} 
#check network ${i} with interface ${i}
#  start program = "/sbin/ifup ${i}"
#  stop program = "/sbin/ifdown ${i}"
#  if failed link then restart
#  if failed link then alert
#  if changed link then alert" >>/root/script/cx9_system
#done