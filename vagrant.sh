# on recupere le nom du dossier a synchroniser dans une variable
echo "Quel dossier voulez vous synchroniser ?"
read folder
# on vérifie si le dossier existe déjà, et si non on le créé
if [ ! -d "$folder" ]; then mkdir $folder
fi
#on créé un fichier vagrant avec notre configuration a l'interieur, et avec des commandes shell pour la suite de l'installation
echo " Vagrant.configure('2') do |config|
    config.vm.box = 'ubuntu/xenial64'
    config.vm.network 'private_network', ip: '192.168.33.10'
    config.vm.synced_folder './$folder', '/var/www/html' 
    config.vm.provision \"shell\",inline: <<-SHELL
    sudo su
    apt-get update -y
    apt-get upgrade -y
    exit
    SHELL
    end" > Vagrantfile
#et on lance vagrant    
vagrant up
vagrant ssh