yum install -y  https://repo.percona.com/yum/percona-release-latest.noarch.rpm
yum install  -y http://repo.percona.com/centos/7/RPMS/x86_64/Percona-Server-selinux-56-5.6.42-rel84.2.el7.noarch.rpm
#yum list | grep percona
yum install -y Percona-Server-server-56 --skip-broken
#if you got error
#yum install Percona-Server-server-56 --skip-broken
systemctl enable mysqld
systemctl start  mysqld
systemctl status mysqld
