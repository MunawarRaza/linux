#Install the packages required to compile RTP engine:
yum install -y iptables-devel kernel-devel kernel-headers xmlrpc-c-devel 
yum install -y "kernel-devel-uname-r == $(uname -r)" 
yum install -y glib glib-devel gcc zlib zlib-devel openssl openssl-devel pcre pcre-devel libcurl libcurl-devel xmlrpc-c xmlrpc-c-devel libevent-devel glib2-devel json-glib-devel gperf libpcap-devel git hiredis hiredis-devel redis perl-IPC-Cmd
#MariaDB ver 10+
yum install MariaDB-devel MariaDB-client MariaDB-shared
#Spandsp
yum install -y spandsp-devel spandsp
#ffmpeg
rpm --import http://li.nux.ro/download/nux/RPM-GPG-KEY-nux.ro
rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-1.el7.nux.noarch.rpm
#install ffmpeg
yum -y install ffmpeg ffmpeg-devel
#Get The Latest Release Of RTPEngine Source From RTPEngine’s GitHub Repository:
cd /usr/local/src
git clone https://github.com/sipwise/rtpengine.git
#Compile and install the daemon
cd /usr/local/src/rtpengine/daemon/
make
cp rtpengine /usr/sbin/rtpengine
#Compile and install iptables extension
cd /usr/local/src/rtpengine/iptables-extension
make all
cp libxt_RTPENGINE.so /usr/lib64/xtables/.
#Compile and install the kernel module xt_RTPENGINE
cd /usr/local/src/rtpengine/kernel-module
make
cp xt_RTPENGINE.ko /lib/modules/3.10.0-1127.18.2.el7.x86_64/extra/xt_RTPENGINE.ko
depmod -a
#load module at boot time
echo "xt_RTPENGINE" >/etc/modules-load.d/rtpengine.conf
#/etc/modules-load.d/rtpengine.conf (past follwing lines)
# load xt_RTPENGINE module
#xt_RTPENGINE
#load the module and check
modprobe xt_RTPENGINE
lsmod | grep xt_RTPENGINE
#check files
ls -l /proc/rtpengine/control
ls -l /proc/rtpengine/list

