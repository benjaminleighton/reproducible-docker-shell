exec { "addrepokey": 
	command => "/usr/bin/sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9",
}

exec { "addrepo": 
	command => '/usr/bin/sudo sh -c "echo deb http://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list"',
	require => Exec["addrepokey"], 
}

exec { "aptupdates":
	command => '/usr/bin/sudo apt-get update',
	require => Exec["addrepo"], 
}

exec { "installdocker":
	command => '/usr/bin/sudo apt-get install -y  lxc-docker',
	require => Exec["aptupdates"], 
}
