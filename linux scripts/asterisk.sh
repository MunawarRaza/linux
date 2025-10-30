

yum install -y epel-release dmidecode gcc-c++ ncurses-devel libxml2-devel make wget openssl-devel newt-devel kernel-devel sqlite-devel libuuid-devel gtk2-devel jansson-devel binutils-devel libedit libedit-devel
adduser asterisk -c "Asterisk User" -p asterisk
#passwd asterisk
usermod -aG wheel asterisk
mkdir ~/build
cd ~/build
wget https://www.pjsip.org/release/2.9/pjproject-2.9.tar.bz2
yum install bzip2 -y
tar xjf pjproject-2.9.tar.bz2
cd pjproject-2.9
./configure CFLAGS="-DNDEBUG -DPJ_HAS_IPV6=1" --prefix=/usr --libdir=/usr/lib64 --enable-shared --disable-video --disable-sound --disable-opencore-amr
make dep
make 
make install && ldconfig
cd ~/build
wget http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-16-current.tar.gz
tar -zxvf asterisk-16-current.tar.gz
cd asterisk-16.12.0
yum install -y svn
sudo ./contrib/scripts/get_mp3_source.sh
sudo contrib/scripts/install_prereq install
./configure --libdir=/usr/lib64 --with-jansson-bundled
#If you get any missing dependencies to install them. In my case, I got the following error:
#yum install patch -y
#make menuselect
make && sudo make install
#To install the sample configuration files, use the command below:
sudo make samples
#To start Asterisk on boot, use:
sudo make config
sudo chown asterisk. /var/run/asterisk
sudo chown asterisk. -R /etc/asterisk
sudo chown asterisk. -R /var/{lib,log,spool}/asterisk
sudo service asterisk start
#sudo asterisk -rvv
