#
#
#Enabling Remi repository
	yum install epel-release yum-utils -y
	yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y
#Installing PHP 7.3 on CentOS 7
	yum-config-manager --enable remi-php73 -y
	yum -y install php php-common php-opcache php-mcrypt php-cli php-gd php-curl php-mysqlnd

#Installing PHP 7.2 on CentOS 7
#	yum-config-manager --enable remi-php72
#	yum install php php-common php-opcache php-mcrypt php-cli php-gd php-curl php-mysqlnd
#Installing PHP 7.2 on CentOS 7
#	yum-config-manager --enable remi-php71
#	yum install php php-common php-opcache php-mcrypt php-cli php-gd php-curl php-mysql
