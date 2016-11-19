# -*- mode: ruby -*-
# vi: set ft=ruby :

# create vagrantfile
echo "# -*- mode: ruby -*-" > vagrantfile
echo "# vi: set ft=ruby :" >> vagrantfile
echo "Vagrant.configure(""2"") do |config|" >> vagrantfile
 
echo "  config.vm.box = ""mesosphere/dcos-centos-virtualbox""" >> vagrantfile
# provision a shared SSH key
echo "  config.ssh.insert_key = false" >> vagrantfile
echo "  config.ssh.private_key_path = [""~/.ssh/id_rsa"",  ""~/.vagrant.d/insecure_private_key""]" >> vagrantfile
echo "  config.vm.provision ""file"", source: ""~/.ssh/id_rsa.pub"", destination: ""~/.ssh/authorized_keys""" >> vagrantfile
echo "  config.vm.provision ""shell"", inline: ""sudo yum -y update""" >> vagrantfile
echo "  config.vm.provision ""shell"", inline: ""sudo timedatectl set-timezone EST""" >> vagrantfile
# SET SWAPPINESS TO 0 TO USE RAM RATHER THAN SWAP
echo "  config.vm.provision :shell, inline: ""sudo sysctl vm.swappiness=0""" >> vagrantfile
echo "  config.vm.provision :shell, inline: ""echo ""vm.swappiness=0"" | sudo tee --append /etc/sysctl.conf""" >> vagrantfile

#Here you can add any provionning shell command or script
#echo "	config.vm.provision :shell, path: ""Provision-script.sh""" >> vagrantfile

echo "  end" >> vagrantfile
	
# Start the old vagrant Box
vagrant up

# stop the new VM
vagrant halt

# Package the new VM
vagrant package --output dcos-centos-virtualbox.box --vagrantfile vagrantfile
vagrant box add .\dcos-centos-virtualbox.box --name mesosphere/dcos-centos-virtualbox  --provider virtualbox
vagrant destroy -f
rm .\dcos-centos-virtualbox.box
