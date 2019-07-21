#!/bin/bash 
# make sure to run script as sudo 


# LDAP 

# update first 
apt-get -q -y update 

# Install php dependencies 

apt-get -y install apache2 php php-cgi libapache2-mod-php php-common php-pear php-mbstring 

a2enconf php7.0-cgi 

service apache2 start

# Pre-seed the slapd passwords 

export DEBIAN_FRONTEND='non-interactive'

echo -e "slapd slapd/root_password password goldenram" |debconf-set-selections
echo -e "slapd slapd/root_password_again password goldenram" |debconf-set-selections

echo -e "slapd slapd/internal/adminpw password goldenram" |debconf-set-selections
echo -e "slapd slapd/internal/generated_adminpw password goldenram" |debconf-set-selections
echo -e "slapd slapd/password2 password goldenram" |debconf-set-selections
echo -e "slapd slapd/password1 password goldenram" |debconf-set-selections
echo -e "slapd slapd/domain string golden.ram" |debconf-set-selections
echo -e "slapd shared/organization string CSC" |debconf-set-selections
echo -e "slapd slapd/backend string HDB" |debconf-set-selections
echo -e "slapd slapd/purge_database boolean true" |debconf-set-selections
echo -e "slapd slapd/move_old_database boolean true" |debconf-set-selections
echo -e "slapd slapd/allow_ldap_v2 boolean false" |debconf-set-selections
echo -e "slapd slapd/no_configuration boolean false" |debconf-set-selections

# Grab slapd and ldap-utils (pre-seeded)
apt-get install -y slapd ldap-utils phpldapadmin

# Must reconfigure slapd for it to work properly 
sudo dpkg-reconfigure slapd 

# Gotta replace the ldap.conf file, it comments out stuff we need set by default - first open it for writing 

chmod 777 /etc/ldap/ldap.conf 

cat <<'EOF' > /etc/ldap/ldap.conf
#
# LDAP Defaults
#

# See ldap.conf(5) for details
# This file should be world readable but not world writable.


BASE    dc=golden,dc=ram
URI     ldap://10.1.0.3 ldap://10.1.0.3:666

#SIZELIMIT      12
#TIMELIMIT      15
#DEREF          never

# TLS certificates (needed for GnuTLS)
TLS_CACERT      /etc/ssl/certs/ca-certificates.crt
EOF

# Be safe again 
chmod 744 /etc/ldap/ldap.conf 


# Now change all values in /etc/phpldapadmin/config.php to their actual values from example, or .com or localhost (I use sed)


# Line 286 
sed -i "s@$servers->setValue('server','name','My LDAP Server');.*@$servers->setValue('server','name','ldap');@" /etc/phpldapadmin/config.php
# Line 293 
sed -i "s@$servers->setValue('server','host','127.0.0.1');.*@$servers->setValue('server','host','10.1.0.3');@" /etc/phpldapadmin/config.php 
# Line 300 
sed -i "s@$servers->setValue('server','base',array('dc=example,dc=com'));.*@$servers->setValue('server','base',array('dc=golden,dc=ram'));@" /etc/phpldapadmin/config.php
# Line 326 
sed -i "s@$servers->setValue('login','bind_id','cn=admin,dc=example,dc=com');.*@$servers->setValue('login','bind_id','cn=admin,dc=golden,dc=ram');@" /etc/phpldapadmin/config.php

# Prevent error when creating users 

sed -i "s@$default = $this->getServer()->getValue('appearance','password_hash');.*@$default = $this->getServer()->getValue('appearance','password_hash_custom');@g" /usr/share/phpldapadmin/lib/TemplateRender.php

service apache2 start

echo ------------------------# 
echo 'PHPldapadmin installed.'
echo ------------------------# 

echo ""

echo ------------------------------------------------------------# 
echo 'Can now access phpldapadmin at http://your-ip/phpldapadmin.'
echo ------------------------------------------------------------# 

echo ""

echo ------------------------------------------------------------------------#
echo 'Username should be acu.local, password is the adminpw set during setup.'
echo ------------------------------------------------------------------------# S

# Logging 

echo -e 'Maven installed -done by' $USER 'at time\n' $DATE '\n' >> /var/log/installs/log.txt
echo -e 'slapd and ldap-utils configured and installed -done by' $USER 'at time\n' $DATE '\n' >> /var/log/installs/log.txt
echo -e 'phpldapadmin install configured -done by' $USER 'at time\n' $DATE '\n' >> /var/log/installs/log.txt
echo -e 'LDAP installed completed by' $USER 'at time\n' $DATE '\n' >> /var/log/installs/log.txt
