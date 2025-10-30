#!/bin/bash
#This is my scrip to install Intellicon
#
echo '######################## WELCOM TO INTELLICON QUICK START ########################'
echo


function install_php(){
echo '######################## SPECIFICTION SECTION ########################'
echo

echo '######################## CHECK UPDATEs ########################'
update=$(yum check-update | grep updates | wc -l)
if [ $update -ge 1 ]; then
	{
		echo 'your system is not updated we are updating it'
		yum update -y
		reboot;
	}
else {
		echo
		echo '######################## Your system is up to dated we can proceed ########################'
		echo	
	}
fi
}

function install_php(){
echo '######################## PHP SECTION ########################'
echo
php=$(rpm -qi php | grep Version | awk '{print $3}' | wc -l);
if [ $php -eq 1 ]; then
		{
		echo 'PHP Already installed'
		echo
		}
else {
		echo 'PHP IS NOT INSTALLED, WE ARE INSTALLING PHP'
		echo
		yum install  --assumeyes epel-release yum-utils wget curl
		yum install  --assumeyes http://rpms.remirepo.net/enterprise/remi-release-7.rpm 
		yum-config-manager --enable remi-php71
		yum install  --assumeyes php php-common php-opcache php-mcrypt php-cli php-gd php-curl php-mysql
		echo
		echo '....................'
		echo
		php=$(php -v | wc -l)
		#if [ $php -ge 1 ];then
		echo $php
		echo
		echo '######################## PHP HAS BEEN INSTALLED ########################'
		echo	
	}
fi
}
function install_httpd(){
echo '######################## HTTPD SECTION ########################'
httpd=$(rpm -qi httpd | grep Version | awk '{print $3}' | wc -l);
if [ $httpd -eq 1 ]; then
		{
		echo
		echo 'HTTPD Already installed'
		}
else {
		echo 'HTTPD IS NOT INSTALLED, WE ARE INSTALLING HTTPD'
		echo
		yum --assumeyes install httpd mod_ssl
		echo
		echo '....................'
		echo
		httpd=$(httpd -v)
		echo $httpd
		echo
		echo '######################## HTTPD HAS BEEN INSTALLED ########################'
		echo
		echo
	}
fi
}

function install_nginx(){
echo '######################## NGINX SECTION ########################'
echo
nginx=$(rpm -qi nginx | grep Version | awk '{print $3}' | wc -l);
if [ $nginx -eq 1 ]; then
		{
		echo
		echo 'NGINX Has Already Been Installed'
		echo
		}
else {
		echo 'NGINX IS NOT INSTALLED, WE ARE INSTALLING NGINX'
		echo
		yum --assumeyes install nginx
		echo
		echo '....................'
		echo
		nginx=$(nginx -v)
		echo $nginx
		echo
		echo '######################## NGINX HAS BEEN INSTALLED ########################'
		echo
	 }
fi
}

function install_percona(){
echo '######################## PERCONA SECTION ########################'
echo
percona=$(mysql --version | awk '{print $5}' | wc -l);
if [ $percona -eq 1 ]; then
		{
		echo
		echo 'PERCONA Has Already Been Installed'
		echo
		}
else {
		echo 'PERCONA IS NOT INSTALLED, WE ARE INSTALLING PERCONA'
		echo
		yum install -y https://repo.percona.com/yum/percona-release-latest.noarch.rpm
		#yum list | grep percona*
		yum install --assumeyes Percona-Server-client-57.x86_64  Percona-Server-devel-57.x86_64 Percona-Server-server-57.x86_64 Percona-Server-shared-57.x86_64
		echo
		echo '....................'
		#echo
		#mysql=$(mysql -v)
		#echo $mysql
		echo
		echo '######################## PERCONA HAS BEEN INSTALLED ########################'
		echo
		echo
	}
fi
}

function install_mongodb(){
echo '######################## INSTALLING MONGODB ########################'
echo
mongod=$(mongod --version | grep 'db version' | awk '{print $3}' | wc -l);
if [ $mongod -eq 1 ]; then
		{
		echo
		echo 'MONGODB Has Already Been Installed'
		echo
		}
else {
		echo 'MONGODB IS NOT INSTALLED, WE ARE INSTALLING MONGODB'
		echo
		touch /etc/yum.repos.d/mongodb-org-4.4.repo
echo '
[mongodb-org-4.4]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.4/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.4.asc' >/etc/yum.repos.d/mongodb-org-4.4.repo
yum install --assumeyes mongodb-org	
		echo
		echo '....................'
		#echo
		mongodb=$(mongod --version)
		echo $mongodb
		echo
		echo '######################## MONGODB HAS BEEN INSTALLED ########################'
		echo
	}
fi
}

function install_rabbitmq(){
echo '######################## INSTALLING RABBITMQ-SERVER ########################'
echo
rabbitmq=$(rabbitmqctl --version | wc -l);
if [ $rabbitmq -eq 1 ]; then
		{
		echo
		echo 'RABBITMQ-SERVER Has Already Been Installed'
		echo
		}
else {
		echo 'RABBITMQ-SERVER IS NOT INSTALLED, WE ARE INSTALLING RABBITMQ-SERVER'
		echo
		echo '################ INSTALLING ERLANG ################'
		yum install --assumeyes gcc gcc-c++ glibc-devel make ncurses-devel openssl-devel autoconf java-1.8.0-openjdk-devel git wget wxBase.x86_64
		wget https://packages.erlang-solutions.com/erlang-solutions-2.0-1.noarch.rpm
		rpm -Uvh erlang-solutions-2.0-1.noarch.rpm
		yum install --assumeyes erlang
		echo '################ ERLANG HAS BEEN INSTALLED ################'
		echo
		echo '################ INSTALLING RABBITMQ-SERVER ################'
		echo
		rpm --import https://www.rabbitmq.com/rabbitmq-signing-key-public.asc
		wget https://github.com/rabbitmq/rabbitmq-server/releases/download/v3.8.5/rabbitmq-server-3.8.5-1.el7.noarch.rpm 
		rpm -Uvh /root/rabbitmq-server-3.8.5-1.el7.noarch.rpm
		echo
		echo '....................'
		echo
		rabbitmq=$(rabbitmqctl --version)
		echo $rabbitmq
		echo
		echo '######################## RABBITMQ-SERVER HAS BEEN INSTALLED ########################'
		echo
		echo
	}
fi
}
install_node(){
	
		echo '######################## NODE SECTION ########################'
		echo
		node=$(node -v | wc -l);
if [ $node -eq 1 ]; then
		{
		echo
		echo 'NODE Has Already Been Installed'
		echo
		}
else {
		echo '######################## INSTALLING NODEJS ########################'
		echo
		curl -sL https://rpm.nodesource.com/setup_10.x | sudo bash -
		yum install --assumeyes nodejs 
		npm i -g pm2 
		echo
		echo '....................'
		echo
		node=$(node --version)
		echo $node
		echo
		echo '######################## NODEJS HAS BEEN INSTALLED ########################'
		echo
		echo
		}
fi
}
install_yarn(){

		echo '######################## YARN SECTION ########################'
		echo
		yarn=$(yarn -v | wc -l);
if [ $yarn -eq 1 ]; then
		{
		echo
		echo 'YARN Has Already Been Installed'
		echo
		}
else {
		echo '######################## INSTALLING YARN ########################'
		echo
		curl -sL https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
		yum install --assumeyes yarn
		echo
		echo '....................'
		echo
		yarn=$(yarn --version)
		echo $yarn
		echo
		echo '######################## YARN HAS BEEN INSTALLED ########################'
		echo
		echo
		}
fi
}

install_redis(){

		echo '######################## REDIS SECTION ########################'
		echo
		redis=$(redis -v | wc -l);
if [ $redis -eq 1 ]; then
		{
		echo
		echo 'REDIS Has Already Been Installed'
		echo
		}
else {

		echo '######################## INSTALLING REDIS ########################'
		echo
		yum install --assumeyes redis
		echo
		echo '....................'
		echo
		redis=$(redis-cli --version)
		echo $redis
		echo
		echo '######################## REDIS HAS BEEN INSTALLED ########################'
		echo
		echo
		}
fi
}

install_centrifugo(){

		echo '######################## CENTRIFUGO SECTION ########################'
		echo
		centrifugo=$(centrifugo version | wc -l);
if [ $centrifugo -eq 1 ]; then
		{
		echo
		echo 'CENTRIFUGO Has Already Been Installed'
		echo
		}
else {
		echo '######################## INSTALLING CENTRIFUGO ########################'
		echo
		curl -s https://packagecloud.io/install/repositories/FZambia/centrifugo/script.rpm.sh | sudo bash
		yum install --assumeyes centrifugo-2.6.2-0.x86_64
		echo
		echo '....................'
		echo
		centrifugo=$(centrifugo version)
		echo $centrifugo
		echo
		echo '######################## CENTRIFUGO HAS BEEN INSTALLED ########################'
		echo
		echo
		}
fi
}

install_asterisk(){
echo '######################## INSTALLING ASTERISK ########################'
echo
sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
setenforce 0
yum install --assumeyes epel-release dmidecode bzip2 gcc-c++ ncurses-devel libxml2-devel make wget openssl-devel newt-devel kernel-devel sqlite-devel libuuid-devel gtk2-devel jansson-devel binutils-devel libedit libedit-devel
wget https://github.com/pjsip/pjproject/archive/2.10.tar.gz
tar xzf /root/2.10.tar.gz
cd root/pjproject-2.10
./configure CFLAGS="-DNDEBUG -DPJ_HAS_IPV6=1" --prefix=/usr --libdir=/usr/lib64 --enable-shared --disable-video --disable-sound --disable-opencore-amr
make dep
make && sudo make install && sudo ldconfig
yum install --assumeyes patch

wget http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-16-current.tar.gz
tar -zxvf /root/asterisk-16-current.tar.gz
cd /root/asterisk-16.15.1/
yum install --assumeyes svn
./contrib/scripts/get_mp3_source.sh
contrib/scripts/install_prereq install
./configure --libdir=/usr/lib64 --with-jansson-bundled
make menuselect.makeopts
menuselect/menuselect --enable format_mp3 --enable res_config_mysql --enable app_mysql --enable cdr_mysql --enable EXTRA-SOUNDS-EN-WAV
make && sudo make install
make samples 
make config
service asterisk status

echo
echo '....................'
echo
#centrifugo=$(centrifugo version)
#echo $centrifugo
#echo
echo '######################## ASTERISK HAS BEEN INSTALLED ########################'
echo
echo
}

install_opensips(){
		echo '######################## OPENSIPS SECTION ########################'
		echo
		opensips=$(opensips -V | wc -l);
if [ $opensips -eq 1 ]; then
		{
		echo
		echo 'OPENSIPS Has Already Been Installed'
		echo
		}
else {
		echo '######################## INSTALLING OPENSIPS ########################'
		echo
		yum install --assumeyes gcc gcc-c++ bison flex zlib-devel openssl-devel mysql-devel subversion pcre-devel ncurses-devel ncurses
		rpm --import http://li.nux.ro/download/nux/RPM-GPG-KEY-nux.ro
		rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm
		yum install --assumeyes opensips
		echo
		echo '....................'
		#echo
		opensips=$(opensips -V)
		echo $opensips
		echo
		echo '######################## OPENSIPS HAS BEEN INSTALLED ########################'
		echo
		echo
		}
fi
}
install_rtpengine(){
		echo '######################## RTPENGINE SECTION ########################'
		echo
		rtpengine=$(rtpengine --version | wc -l);
if [ $rtpengine -eq 1 ]; then
		{
		echo
		echo 'RTPENGINE Has Already Been Installed'
		echo
		}
else {

		echo '######################## INSTALLING RTPENGINE ########################'
		echo
		yum install --assumeyes iptables-devel kernel-devel kernel-headers xmlrpc-c-devel
		yum install --assumeyes "kernel-devel-uname-r == $(uname -r)" 
		yum -y install kernel-devel
		yum -y update kernel
		yum install -assumeyes glib glib-devel gcc zlib zlib-devel openssl openssl-devel pcre pcre-devel libcurl libcurl-devel xmlrpc-c xmlrpc-c-devel libevent-devel glib2-devel json-glib-devel gperf libpcap-devel git hiredis hiredis-devel redis perl-IPC-Cmd mysql-devel
		yum install --assumeyes spandsp-devel spandsp
		rpm --import http://li.nux.ro/download/nux/RPM-GPG-KEY-nux.ro
		rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-1.el7.nux.noarch.rpm
		yum --assumeyes install ffmpeg ffmpeg-devel
		mkdir /usr/local/downloads
		cd /usr/local/downloads/
		git clone https://github.com/sipwise/rtpengine.git rtpengine
		cd /usr/local/downloads/rtpengine/daemon/
		make 
		cp rtpengine /usr/sbin/rtpengine
		cd /usr/local/downloads/rtpengine/iptables-extension
		make all
		cp libxt_RTPENGINE.so /usr/lib64/xtables/.
		cd /usr/local/downloads/rtpengine/kernel-module/
		make 
		version=$(uname -r)
		cp xt_RTPENGINE.ko /lib/modules/$version/extra/
		mkdir /etc/rtpengine/
		depmod -a
		echo "xt_RTPENGINE" >/etc/modules-load.d/rtpengine.conf
		modprobe xt_RTPENGINE
		touch /usr/lib/systemd/system/rtpengine.service
echo '
[Unit]
Description=Kernel based rtp proxy
After=syslog.target
After=network.target
[Service]
Type=forking
PIDFile=/var/run/rtpengine.pid
EnvironmentFile=-/etc/rtpengine/rtpengine.conf
ExecStart=/usr/sbin/rtpengine -p /var/run/rtpengine.pid 
Restart=always
[Install]
WantedBy=multi-user.target' > /usr/lib/systemd/system/rtpengine.service
		chmod +x /usr/lib/systemd/system/rtpengine.service
		#echo
		echo '....................'
		#echo
		rtpengine=$(rtpengine --version)
		echo $rtpengine
		echo
		echo '######################## RTPENGINE HAS BEEN INSTALLED ########################'
		echo
		echo
	}
fi
}

install_agispeedy(){
echo '######################## INSTALLING AGISPEEDY ########################'
echo
git clone https://munawar.raza:Contegris.068@git.contegris.com/root/agispeedy-7.1.x.git /etc/agispeedy/
cd /etc/agispeedy/
cp contrib/agispeedy /etc/init.d/
chmod +x /etc/init.d/agispeedy
/etc/init.d/agispeedy status
echo
echo '....................'
#echo
#opensips=$(opensips -v)
#echo $opensips
echo
echo '######################## AGISPEEDY HAS BEEN INSTALLED ########################'
echo
echo
}

install_turnserver(){
		echo '######################## TURNSERVER SECTION ########################'
		echo
		turnserver=$(ps -ef | grep turnserver | wc -l);
if [ $turnserver -eq 1 ]; then
		{
		echo
		echo 'TURNSERVER Has Already Been Installed'
		echo
		}
else {

		echo '######################## INSTALLING TURNSERVER ########################'
		echo
		cd /usr/local/downloads/
		wget https://github.com/downloads/libevent/libevent/libevent-2.0.21-stable.tar.gz 
		tar xzf libevent-2.0.21-stable.tar.gz
		cd libevent-2.0.21-stable
		./configure
		make
		make install
		cd /usr/local/downloads/
		wget http://turnserver.open-sys.org/downloads/v3.2.3.8/turnserver-3.2.3.8.tar.gz
		tar xzf turnserver-3.2.3.8.tar.gz
		cd turnserver-3.2.3.8
		./configure
		make
		make install
		echo
		echo '....................'
		echo
		echo '######################## TURNSERVER HAS BEEN INSTALLED ########################'
		echo
		echo
	}
fi
}

git_cx9(){
echo '######################## CLONNING INTELLICON CX9 ########################'
echo
echo '---------- CLONNING INTELLICON ----------'
echo
git clone https://munawar.raza:Contegris.068@git.contegris.com/intellicon-x9/intellicon-production.git /var/www/html/intellicon/
echo
echo '---------- CLONNING CX9-SERVERS ----------'
echo
git clone https://munawar.raza:Contegris.068@git.contegris.com/cx9-production/cx9-servers-production.git /root/cx9/cx9-servers/
echo
echo '---------- CLONNING UI ----------'
git clone https://munawar.raza:Contegris.068@git.contegris.com/cx9-production/cx9-ui-production.git /root/cx9/ui/
echo
echo '---------- CLONNING NODE ----------'
git clone https://munawar.raza:Contegris.068@git.contegris.com/habibshahid/node.git /etc/node/
echo
echo '---------- PLACING UI TO CX9 ----------'
echo
mkdir /var/www/html/cx9/
yes | cp -prf /root/cx9/ui/build/* /var/www/html/cx9/
echo
echo '---------- CLONNING ASTERISK INTELLICON ----------'
echo
git clone https://munawar.raza:Contegris.068@git.contegris.com/root/asterisk_intellicon.git /var/www/html/asterisk_intellicon/
echo
echo '---------- PLACING ASTERISK INTELLICON FILES ----------'
echo
chmod -R 777 /var/www/html/asterisk_intellicon/
yes | cp -prf /var/www/html/asterisk_intellicon/* /etc/asterisk/
echo
echo '---------- ASTERISK INTELLICON FILES HAS BEEN PLACED----------'
echo
echo '---------- CLONNING IWGW ----------'
echo
git clone https://munawar.raza:Contegris.068@//git.contegris.com/cicd/iwgw.git /etc/iwgw/
echo
echo '---------- IWGW HAS BEEN CLONED ----------'
echo
echo '....................'
echo
echo '######################## INTELLICON-CX9 HAS BEEN CLONED ########################'
echo
echo
}
configure_php(){
		echo '######################## PHP CONFIGURATION SECTION ########################'
		echo
		php_config=$(cat /etc/php.ini | grep 'zend_extension = /usr/lib64/ioncube_loader_lin_7.1.so');
if [ $php_config -eq 1 ]; then
		{
		echo
		echo 'PHP Has Already Been Configured'
		echo
		}
else {
		echo '######################## CONFUGURING PHP ########################'
		echo
		cd /root/
		wget https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz 
		tar xzf /root/ioncube_loaders_lin_x86-64.tar.gz
		cp /root/ioncube/ioncube_loader_lin_7.1.so /usr/lib64/php/modules/
		echo 'zend_extension = /usr/lib64/ioncube_loader_lin_7.1.so' >>/etc/php.ini
		echo
		echo '######################## PHP HAS BEEN CONFIGURED ########################'
		echo
		echo
	}
fi
}

configure_redis(){
echo '######################## CONFUGURING REDIS ########################'
echo
echo 'requirepass intelliR3d!$' >>/etc/redis.conf
sed -i 's/notify-keyspace-events ""/notify-keyspace-events "Ex"/g ' /etc/redis.conf
echo
echo '######################## REDIS HAS BEEN CONFIGURED ########################'
echo
echo
}
configure_sudoers(){
echo '######################## CONFUGURING SUDOERS FILE ########################'
echo
echo 'apache ALL=(ALL)       NOPASSWD: ALL' >>/etc/sudoers
echo
echo '######################## SUDOERS FILE HAS BEEN CONFIGURED ########################'
echo
echo
}
configure_mysql(){

		echo '######################## CONFUGURING MYSQL ########################'
		echo
		touch /etc/my.cnf.d/global.cnf
		echo '
		[mysqld]
		sql_mode="STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION"
		validate_password_mixed_case_count      =       0
		validate_password_number_count          =       0
		validate_password_special_char_count    =       0
		max_connections = 500' >> /etc/my.cnf.d/global.cnf
		echo
		echo '######################## MYSQL HAS BEEN CONFIGURED ########################'
		echo
		echo
	}


configure_rtpengine(){
echo '######################## CONFUGURING RTPENGINE ########################'
echo
yes | cp -prf /etc/iwgw/rtpengine.conf
add=$(ip a | grep 'state UP' -A2 | grep inet | awk '{print $2}' | cut -f1 -d'/')
sed -i 's/IPADDRESS/$add/g' /etc/rtpengine/rtpengine.conf
echo
echo '######################## RTPENGINE HAS BEEN CONFIGURED ########################'
echo
echo
}
configure_opensips(){
echo '######################## CONFUGURING OPENSIPS ########################'
echo
mv /etc/opensips/opensips.cfg /etc/opensips/opensips.cfg.old 
yes | cp -prf /etc/iwgw/opensips.cfg /etc/opensips/
add=$(ip a | grep 'state UP' -A2 | grep inet | awk '{print $2}' | cut -f1 -d'/')
sed -i 's/IPADDRESS/$add/g' /etc/opensips/opensips.cfg
echo
echo '######################## OPENSIPS HAS BEEN CONFIGURED ########################'
echo
echo
}
configure_nginx(){
echo '######################## CONFUGURING NGINX ########################'
echo
mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.old
yes | cp -prf /etc/iwgw/nginx.conf /etc/nginx/
echo
echo '######################## NGINX HAS BEEN CONFIGURED ########################'
echo
echo
}
configure_httpd(){
echo '######################## CONFUGURING HTTPD ########################'
echo
echo '
<Directory /var/www/html/intellicon>
        Options FollowSymLinks
        AllowOverride All
        Order allow,deny
        Allow from all
</Directory>

<Directory /var/www/html/intellidesk>
        Options FollowSymLinks
        AllowOverride All
        Order allow,deny
        Allow from all
</Directory>

<Directory /var/www/html/intellix>
        Options FollowSymLinks
        AllowOverride All
        Order allow,deny
        Allow from all
</Directory>' >>/etc/httpd/conf/httpd.conf
echo
echo '######################## HTTPD HAS BEEN CONFIGURED ########################'
echo
echo
}

install_node_module(){
echo '######################## INSTALLING NODE MODULE ########################'
echo
echo '---------- RUNNING YARN INSTALL ----------'
cd /etc/node && yarn install
echo
echo '---------- RUNNING NODE INSTALL.JS ----------'
echo
cd /root/cx9/cx9-servers/ && node install.js
echo
echo '######################## NODE MODULE HAS BEEN INSTALLED ########################'
echo
echo
}

#check_system_update
#install_php
#install_httpd
#install_nginx
#install_percona
#install_mongodb
#install_rabbitmq
#install_node
#install_yarn
#install_redis
#install_centrifugo
install_asterisk
#install_opensips
#install_rtpengine
#install_agispeedy
#install_turnserver
#git_cx9
#configure_php
#configure_redis
#configure_sudoers
#configure_mysql
#configure_rtpengine
#configure_opensips
#configure_nginx
#configure_httpd
#install_node_module






