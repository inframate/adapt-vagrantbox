# adapt-vagrantbox
a powershell script to adapt a centOS vagrantbox and push it to the local vagrant box repository
- create a vagrantfile to :
    - provision a shared SSH key (uses the key in ~/.ssh/id_rsa)
    - update package list
    - setup timezone
    - SET SWAPPINESS TO 0 TO USE RAM RATHER THAN SWAP
- Start a VM with the old vagrant Box
- If you have the vagrant plugin for Virtualbox guest additions they will be installed/updated
- Stop the new VM
- Package the new VM into a new box and add it to vagrant local boxes
- cleanup
