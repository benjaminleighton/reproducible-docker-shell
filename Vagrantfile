Vagrant.configure("2") do |config|

	config.vm.box = "chef/ubuntu-13.10"
	config.vm.network :forwarded_port, guest: 80, host: 3000 
	
	config.vm.provider :virtualbox do |box|
		# Don't boot with headless mode
		box.gui = true
	end
	
	config.vm.provision "shell", 
		inline: '/usr/bin/sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9 && /usr/bin/sudo sh -c "echo deb http://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list" && /usr/bin/sudo apt-get update && /usr/bin/sudo apt-get install -y  lxc-docker'

end
