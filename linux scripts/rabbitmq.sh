#download erlang package
wget https://packages.erlang-solutions.com/erlang-solutions-2.0-1.noarch.rpm
#add repository
rpm -Uvh /home/raza/rabbitmq/test1/erlang-solutions-2.0-1.noarch.rpm
#install 
yum -y install erlang socat logrotate
#download rabbitmq
wget https://github.com/rabbitmq/rabbitmq-server/releases/download/v3.8.5/rabbitmq-server-3.8.5-1.el7.noarch.rpm
#import public
rpm --import https://www.rabbitmq.com/rabbitmq-signing-key-public.asc
#install downloaded version
rpm -Uvh /home/raza/rabbitmq/test1/rabbitmq-server-3.8.5-1.el7.noarch.rpm
#start and enable rabbitmq services
systemctl start rabbitmq-server
systemctl enable rabbitmq-server
#enable GUI of rabbitmq
rabbitmq-plugins enable rabbitmq_management
#modify permissions
chown -R rabbitmq:rabbitmq /var/lib/rabbitmq/
#Create an admin user and give password to that user
rabbitmqctl add_user admin password
#Make admin user and administrator
rabbitmqctl set_user_tags admin administrator
#Set admin user permissions
sudo rabbitmqctl set_permissions -p / admin ".*" ".*" ".*"
