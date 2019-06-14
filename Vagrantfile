Vagrant.configure("2") do |config|
# VM da API CEP
	config.vm.box = "bento/centos-7.4"

config.vm.define "api_cep" do |api_cep|
api_cep.vm.network "private_network", ip: "192.168.1.87"
api_cep.vm.synced_folder ".", "/var/www/html"
api_cep.vm.provision 'shell', path: "script_api.sh"
api_cep.vm.provider "virtualbox" do |vb|
	vb.name = "api_cep"
	vb.memory = "1024"
	end
end
	
	#Primeira VM Servidor do Zabbix
  config.vm.define "z_server" do |z_server|
    z_server.vm.hostname = "zserver"
    z_server.vm.network "private_network", ip: "192.168.1.88"
    z_server.vm.provision 'shell', path: "script_z_server.sh"
    z_server.vm.provider "virtualbox" do |vb|
      vb.name = "z_server"
      vb.memory = "2048"
    end
  end
	#Segunda VM Host Linux a ser monitorado
  config.vm.define "z_host" do |z_host|
    z_host.vm.hostname = "zhost"
    z_host.vm.network "private_network", ip: "192.168.1.89"
    z_host.vm.provision 'shell', path: "script_z_host.sh"
    z_host.vm.provider "virtualbox" do |vb|
      vb.name = "z_host"
      vb.memory = "1024"
    end
  end
end