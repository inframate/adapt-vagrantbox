$Vagrantbox =  "simo/CentOS7-Zabbix3_2-All"
$Vagrantboxfile = "CentOS7-Zabbix3_2-All.box"
$Vagrantfile= "vagrantfile"
$provider="virtualbox"
$error.clear()
# Start the old vagrant Box
echo "vagrant up"
vagrant up
# stop the new VM
echo "vagrant halt"
vagrant halt
if ($?) {
	# Package the new VM into a new box, add it to vagrant local boxes and then clean up all
	echo "Packaging..."
	vagrant package --output $Vagrantboxfile 
	if ($?) {
		echo "Adding Box $Vagrantbox ..."
		vagrant box add $Vagrantboxfile --name $Vagrantbox --force --provider $provider
		if ($?) {
			echo "Destroying the VM..."
			vagrant destroy -f
			if ($?) {
				echo "Removing $Vagrantboxfile ..."
				rm $Vagrantboxfile
			}
		}
	}
}
