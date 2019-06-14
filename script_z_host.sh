#!/bin/bash
yum -y install vim; yum -y install net-tools

#Instalar o agente e copiar a configuracao
yum -y install http://repo.zabbix.com/zabbix/3.2/rhel/7/x86_64/zabbix-release-3.2-1.el7.noarch.rpm
yum -y install zabbix-agent
cp /vagrant/zabbix_agentd.confhost /etc/zabbix/zabbix_agentd.conf
systemctl start zabbix-agent

echo   "*******************************************************************************************"
echo   "|                                                                                         |"
echo   "| Teste para vaga de analista de Infraestrutura de TI na MaxMilhas                        |"
echo   "| Criado por Juliana em 14/06/2019                                                        |"
echo   "|                                                                                         |"
echo   "|  Olá, Victor! Seguem os dados para acesso às ferramentas através do navegador web:      |"
echo   "|  * API consulta CEP: http://192.168.1.87                                                |"
echo   "|  * Zabbix Server: http://192.168.1.88/zabbix                                            |"
echo   "|    Zabbix User: Admin                                                                   |"
echo   "|    Zabbix Pass: zabbix                                                                  |"
echo   "|  * Zabiix Host: 192.168.1.89                                                            |"
echo   "|_________________________________________________________________________________________|"