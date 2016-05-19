# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # use a centos 7 box
    config.vm.box = "bento/centos-7.2"

    # set the hostname
    config.vm.hostname = "centos7"

    # Create a private network, which allows host-only access to the machine
    # using a specific IP.
    config.vm.network "private_network", type: "dhcp"

    config.vm.provider "virtualbox" do |vb|
        # Use VBoxManage to customize the VM. For example to change memory:
        vb.customize ["modifyvm", :id, "--memory", "1024"]
    end

    # install puppet with ansible :facepalm:
    config.vm.provision "ansible", run: "once" do |ansible|
        ansible.playbook = "vagrant/playbook.yml"
    end

    # provision with puppet
    config.vm.provision "puppet" do |puppet|
        # allow custom args
        puppet.options = ENV.fetch("PUPPET_ARGS", "")

        # setup hiera
        puppet.hiera_config_path = "hiera.yml"
        puppet.working_directory = "/vagrant"

        # setup manifest path
        puppet.manifests_path = "manifests"
        puppet.manifest_file = "default.pp"
        # setup module path
        puppet.module_path = "modules"

        # define custom facts
        puppet.facter = {

        }
    end
end
