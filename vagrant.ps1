# creae vagrantfile
echo "# -*- mode: ruby -*-" > vagrantfile
echo "# vi: set ft=ruby :" >> vagrantfile
echo "Vagrant.configure(""2"") do |config|" >> vagrantfile
 
echo "  config.vm.box = ""centos""" >> vagrantfile
# provision a shared SSH key
echo "  config.ssh.insert_key = false" >> vagrantfile
echo "  config.ssh.private_key_path = [""~/.ssh/id_rsa"",  ""~/.vagrant.d/insecure_private_key""]" >> vagrantfile
echo "  config.vm.provision ""file"", source: ""~/.ssh/id_rsa.pub"", destination: ""~/.ssh/authorized_keys""" >> vagrantfile
echo "  config.vm.provision ""shell"", inline: <<-SHELL" >> vagrantfile
echo "    sudo yum -y update" >> vagrantfile
echo "    sudo timedatectl set-timezone EST" >> vagrantfile
# SET SWAPPINESS TO 0 TO USE RAM RATHER THAN SWAP
echo "    sudo sysctl vm.swappiness=0" >> vagrantfile
echo "    echo ""vm.swappiness=0"" | sudo tee --append /etc/sysctl.conf" >> vagrantfile
echo "  SHELL" >> vagrantfile
#Here you can add any provionning shell command or script
#echo "	config.vm.provision :shell, path: ""Provision-script.sh""" >> vagrantfile

echo "  end" >> vagrantfile
echo "end" >> vagrantfile	
# Start the old vagrant Box
vagrant up

# stop the new VM
vagrant halt

# Package the new VM
vagrant package --output centos.box --vagrantfile vagrantfile
vagrant box add .\centos.box --name mesosphere/dcos-centos-virtualbox  --provider virtualbox
vagrant destroy -f
rm .\dcos-centos-virtualbox.box
