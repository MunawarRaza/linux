#!/bin/bash

for pid in $(ps -ef | grep java | awk '{print $2}'); do
    if [ -f /proc/$pid/smaps ]; then
            echo "* Mem usage for PID $pid"
            echo "-- Size:"
            cat /proc/$pid/smaps | grep -m 1 -e ^Size: | awk '{print $2}'
            echo "-- Rss:"
            cat /proc/$pid/smaps | grep -m 1 -e ^Rss: | awk '{print $2}'
            echo "-- Pss:"
            cat /proc/$pid/smaps | grep -m 1 -e ^Pss: | awk '{print $2}'
            echo "Shared Clean"
            cat /proc/$pid/smaps | grep -m 1 -e '^Shared_Clean:' | awk '{print $2}'
            echo "Shared Dirty"
            cat /proc/$pid/smaps | grep -m 1 -e '^Shared Dirty:' | awk '{print $2}'
    fi
done




for pid in $(ps -ef | grep java | awk '{print $2}'); do
    if [ -f /proc/$pid/smaps ]; then
            echo "* Mem usage for PID $pid"
            echo "-- Size:"
            cat /proc/$pid/smaps | grep -m 1 -e ^Size: | awk '{print $2}'
            echo "-- Rss:"
            
    fi
done




#!/bin/bash

for pid,user in $(ps -ef | awk '{print $2,$8}'); do
    if [ -f /proc/$pid/smaps ]; then
        echo "* Mem usage for PID $pid"     
        rss=$(awk 'BEGIN {i=0} /^Rss/ {i = i + $2} END {print i}' /proc/$pid/smaps)
        pss=$(awk 'BEGIN {i=0} /^Pss/ {i = i + $2 + 0.5} END {print i}' /proc/$pid/smaps)
        #sc=$(awk 'BEGIN {i=0} /^Shared_Clean/ {i = i + $2} END {print i}' /proc/$pid/smaps)            
        #sd=$(awk 'BEGIN {i=0} /^Shared_Dirty/ {i = i + $2} END {print i}' /proc/$pid/smaps)
        #pc=$(awk 'BEGIN {i=0} /^Private_Clean/ {i = i + $2} END {print i}' /proc/$pid/smaps)
        #pd=$(awk 'BEGIN {i=0} /^Private_Dirty/ {i = i + $2} END {print i}' /proc/$pid/smaps)
        echo "-- Rss: $rss kB" 
        echo "-- Pss: $pss kB"
        #echo "Shared Clean $sc kB"
        #echo "Shared Dirty $sd kB"
        #echo "Private $(($pd + $pc)) kB"
    fi
done


#!/bin/bash
RAWIN=$(ps -o pid,user,%mem,command ax | grep -v PID | sort -bnr -k3 | awk '/[0-9]*/{print $1 ":" $2 ":" $3 ":" $4}')
for i in $RAWIN
do
  #echo $i
 PID=$(echo $i | cut -d: -f1)
 OWNER=$(echo $i | cut -d: -f2)
 COMMAND=$(echo $i | cut -d: -f3)
 MEMORY=$(sudo pmap $PID | tail -n 1 | awk  '/[0-9]K/{print $2}')
 RESULT = MEMORY/1024
   echo "PID: $PID"
   echo "OWNER: $OWNER"
   echo "COMMAND: $COMMAND"
   echo "MEMORY: $MEMORY"
   echo "RESULT"
   echo " "
done





for pid in $(ps -ef | awk '{print $2}'); do
    if [ -f /proc/$pid/smaps ]; then
        result1=$(cat /proc/$pid/smaps | grep -i rss |  awk '{Total+=$2} END {print Total/1024" MB"}')     
        echo "* Mem usage for PID $pid | $result1"
        #echo "Here is result: $result1"

    fi
done


#!/bin/bash
RAWIN=$(ps -o pid,user,%mem,command ax | grep -v PID | sort -bnr -k3 | awk '/[0-9]*/{print $1 ":" $2 ":" $3 ":" $4}')
for i in $RAWIN
do
  #echo $i
 PID=$(echo $i | cut -d: -f1)
 OWNER=$(echo $i | cut -d: -f2)
 COMMAND=$(echo $i | cut -d: -f3)
 MEMORY=$(sudo pmap $PID | tail -n 1 | awk  '/[0-9]K/{print $2}')
 RESULT = MEMORY/1024
   echo "PID: $PID"
   echo "OWNER: $OWNER"
   echo "COMMAND: $COMMAND"
   echo "MEMORY: $MEMORY"
   echo "RESULT"
   echo " "
done

