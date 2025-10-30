#!/bin/bash

#INTERFACES='1,2,3'
#i=1
for i in $(ip a|grep "state UP" |awk '{print $2}' |cut -d':' -f1)
do
echo "Welcome ${i} heeelo ${i}" >>/root/script/file

done