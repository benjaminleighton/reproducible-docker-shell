Vagrant.configure("2") do |config|

	config.vm.box = "chef/ubuntu-13.10"
	config.vm.network :forwarded_port, guest: 80, host: 3000 
	
	config.vm.provider :virtualbox do |box|
		# Don't boot with headless mode
		box.gui = true
	end
	
	config.vm.provision "shell", 
	    	inline: "sudo apt-get -y install puppet"

	config.vm.provision :puppet do |puppet|
		puppet.manifests_path = "puppet/manifests"
		puppet.manifest_file = "default.pp"
	end

end
