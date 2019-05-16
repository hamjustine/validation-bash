 Vagrant.configure('2') do |config|
    config.vm.box = 'ubuntu/xenial64'
    config.vm.network 'private_network', ip: '192.168.33.10'
    config.vm.synced_folder './toto', '/var/www/html' 
    config.vm.provision "shell",inline: <<-SHELL
    sudo su
    apt-get update -y
    apt-get upgrade -y
    exit
    SHELL
    end
