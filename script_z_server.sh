#!/bin/bash
yum -y install vim
yum -y install net-tools
yum -y install build-essential

#Instalacao do servidor
pas=password
yum -y install mariadb mariadb-server
/usr/bin/mysql_install_db --user=mysql
systemctl start mariadb
mysql -uroot  << EOF
create database zabbix character set utf8 collate utf8_bin;
grant all privileges on zabbix.* to zabbix@localhost identified by 'password'; 
EOF
#Arquivos de configuraçao do zabbix
yum -y install http://repo.zabbix.com/zabbix/3.2/rhel/7/x86_64/zabbix-release-3.2-1.el7.noarch.rpm
yum -y install zabbix-server-mysql zabbix-web-mysql
zcat /usr/share/doc/zabbix-server-mysql-*/create.sql.gz | mysql -uzabbix -ppassword zabbix
cp /vagrant/zabbix_server.conf /etc/zabbix/
systemctl start zabbix-server 
cp /vagrant/zabbix.conf /etc/httpd/conf.d/
cp /vagrant/httpd.conf /etc/httpd/conf/httpd.conf
cp /vagrant/zabbix.conf.php /etc/zabbix/web/
systemctl start httpd


#Instalar zabbix agente	
yum -y install http://repo.zabbix.com/zabbix/3.2/rhel/7/x86_64/zabbix-release-3.2-1.el7.noarch.rpm
yum -y install zabbix-agent
cp /vagrant/zabbix_agentd.conf /etc/zabbix/
systemctl start zabbix-agent

#Arquivo que insere os hosts no zabbix pela API
/vagrant/script_registration_on_zabbix_server.sh
/vagrant/script_registration_on_zabbix_cep.sh
/vagrant/script_importacao_template.sh
