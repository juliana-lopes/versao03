# yum -y update
yum -y install httpd
firewall-cmd --permanent --add-port=80/tcp
firewall-cmd --permanent --add-port=443/tcp
firewall-cmd --reload
systemctl enable httpd
systemctl start httpd
   
  echo  "   Webservice API ok      " 