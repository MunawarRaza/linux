echo ""
echo "============================================================="
echo "            <<  Welcome $USER To Jboss Server     "
echo "============================================================="
#echo "============================================================="
#echo "$(cat /etc/redhat-release)"
echo "Total Memory              | $(free -h | grep -i Mem | awk '{print $2}')"
echo "Available Memory          | $(free -h | grep -i Mem | awk '{print $7}')"
echo "Disk Size                 | $(df -h | grep -i /dev/sda4 | awk '{print $2}')"
echo "Free Disk Size            | $(df -h | grep -i /dev/sda4 | awk '{print $4}')"
echo "Up Time                   | $(uptime | awk '{print $1,$2,$3,$4,$5,$6}')"
echo "System Clock              | $(date)"
echo "IP Address                | $(ip a |grep inet |sed -n 3p |awk '{print $2}' |cut -d"/" -f1)"
echo "Logged in Users           | $(who |awk '{print $1}' |sort -u |wc -l)"
echo "You Last Logged in        | $(last -a |grep $USER |grep -A1 still |awk '{print $3,$4,$5,$6,$10}' |tail -n1)"
#echo "Hardware Clock            | $(hwclock)"
echo
echo "                 *******************************"
echo "                      << Services Status "
echo "                 *******************************"
echo

JBOSS_P=$(ps -ef |grep java |awk '{print $2}')

if [[ -n $JBOSS_P ]];
then

echo "Jboss Status              | Active"

else

echo "Jboss Status              | In-Active"
fi

echo "Apache Status             | $(systemctl status apache2 | grep Active | awk $'{print $2}')"

echo


#++++++++++++++++++++++++++++++++++++++++++ Micro Services ++++++++++++++++++++++++++++++++++++++++++

echo ""
echo "============================================================="
echo "            <<  Welcome $USER  >>"
echo "============================================================="
#echo "============================================================="
#echo "$(cat /etc/redhat-release)"
echo "Total Memory              | $(free -h | grep -i Mem | awk '{print $2}')"
echo "Available Memory          | $(free -h | grep -i Mem | awk '{print $7}')"
echo "Disk Size                 | $(df -h | grep -i /dev/sda4 | awk '{print $2}')"
echo "Free Disk Size            | $(df -h | grep -i /dev/sda4 | awk '{print $4}')"
echo "Up Time                   | $(uptime | awk '{print $1,$2,$3,$4,$5,$6}')"
echo "System Clock              | $(date)"
echo "IP Address                | $(ip a |grep inet |sed -n 3p |awk '{print $2}' |cut -d"/" -f1)"
echo "Logged in Users           | $(who |awk '{print $1}' |sort -u |wc -l)"
echo "You Last Logged in        | $(last -a |grep $USER |grep -A1 still |awk '{print $3,$4,$5,$6,$10}' |tail -n1)"
#echo "Hardware Clock            | $(hwclock)"
echo
echo "                 ***********************************************"
echo "                      <<  Following Services are running  >> "
echo "                 ***********************************************"
echo

 ps -ef |grep java |awk 'BEGIN { print "User    PID     ServiceName"} {print $1,"   "$2,"    "$10}'  |grep -v $USER

echo
