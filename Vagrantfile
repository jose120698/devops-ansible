# -*- mode: ruby -*-
# vi: set ft=ruby :

machines = {
  'vagrant' => {
    'box' => 'travisrowland/centos7',
    # VM => HOST
    'local_ports' => {
      # Traefik
      '80' => '8880',
      # Jenkins
      '8080' => '8880',
      # Jenkins
      '5000' => '5000',
      # Rundeck
      '4440' => '4440',
      # Artifactory
      '8081' => '8888',
      # PostgresSQL
      '5432' => '5432',
      # SonarQube
      '9000' => '9000',
      # SonarQube
      '9092' => '9092',
    },
  },
}

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  machines.each do |vm, specs|
    config.vm.define vm do |machine|
      # All Vagrant configuration is done here. The most common configuration
      # options are documented and commented below. For a complete reference,
      # please see the online documentation at vagrantup.com.

      # Every Vagrant virtual environment requires a box to build off of.
      # machine.vm.box = "ubuntu/trusty64"
      machine.vm.box = specs['box']

      # Disable automatic box update checking. If you disable this, then
      # boxes will only be checked for updates when the user runs
      # `vagrant box outdated`. This is not recommended.
      # machine.vm.box_check_update = false

      # Create a forwarded port mapping which allows access to a specific port
      # within the machine from a port on the host machine. In the example below,
      # accessing "localhost:8080" will access port 80 on the guest machine.
      # machine.vm.network "forwarded_port", guest: 80, host: 8080

      specs['local_ports'].each do |guest_port, host_port|
        machine.vm.network "forwarded_port", guest: guest_port, host: host_port
      end

      # Create a private network, which allows host-only access to the machine
      # using a specific IP.
      # machine.vm.network "private_network", ip: "192.168.33.10"

      # Create a public network, which generally matched to bridged network.
      # Bridged networks make the machine appear as another physical device on
      # your network.
      # machine.vm.network "public_network"

      # If true, then any SSH connections made will enable agent forwarding.
      # Default value: false
      # config.ssh.forward_agent = true

      # Share an additional folder to the guest VM. The first argument is
      # the path on the host to the actual folder. The second argument is
      # the path on the guest to mount the folder. And the optional third
      # argument is a set of non-required options.
      # machine.vm.synced_folder "../data", "/vagrant_data"
      machine.vm.synced_folder ".", "/vagrant", :mount_options => ["dmode=777","fmode=644"]

      # Provider-specific configuration so you can fine-tune various
      # backing providers for Vagrant. These expose provider-specific options.
      # Example for VirtualBox:
      #
      # machine.vm.provider "virtualbox" do |vb|
      #   # Don't boot with headless mode
      #   vb.gui = true
      #
      #   # Use VBoxManage to customize the VM. For example to change memory:
      #   vb.customize ["modifyvm", :id, "--memory", "1024"]
      # end
      #
      # View the documentation for the provider you're using for more
      # information on available options.
      machine.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", 768]
      end

      # Enable provisioning with CFEngine. CFEngine Community packages are
      # automatically installed. For example, configure the host as a
      # policy server and optionally a policy file to run:
      #
      # machine.vm.provision "cfengine" do |cf|
      #   cf.am_policy_hub = true
      #   # cf.run_file = "motd.cf"
      # end
      #
      # You can also configure and bootstrap a client to an existing
      # policy server:
      #
      # machine.vm.provision "cfengine" do |cf|
      #   cf.policy_server_address = "10.0.2.15"
      # end

      # Enable provisioning with Puppet stand alone.  Puppet manifests
      # are contained in a directory path relative to this Vagrantfile.
      # You will need to create the manifests directory and a manifest in
      # the file default.pp in the manifests_path directory.
      #
      # machine.vm.provision "puppet" do |puppet|
      #   puppet.manifests_path = "manifests"
      #   puppet.manifest_file  = "default.pp"
      # end

      # Enable provisioning with chef solo, specifying a cookbooks path, roles
      # path, and data_bags path (all relative to this Vagrantfile), and adding
      # some recipes and/or roles.
      #
      # machine.vm.provision "chef_solo" do |chef|
      #   chef.cookbooks_path = "../my-recipes/cookbooks"
      #   chef.roles_path = "../my-recipes/roles"
      #   chef.data_bags_path = "../my-recipes/data_bags"
      #   chef.add_recipe "mysql"
      #   chef.add_role "web"
      #
      #   # You may also specify custom JSON attributes:
      #   chef.json = { mysql_password: "foo" }
      # end

      # Enable provisioning with chef server, specifying the chef server URL,
      # and the path to the validation key (relative to this Vagrantfile).
      #
      # The Opscode Platform uses HTTPS. Substitute your organization for
      # ORGNAME in the URL and validation key.
      #
      # If you have your own Chef Server, use the appropriate URL, which may be
      # HTTP instead of HTTPS depending on your configuration. Also change the
      # validation key to validation.pem.
      #
      # machine.vm.provision "chef_client" do |chef|
      #   chef.chef_server_url = "https://api.opscode.com/organizations/ORGNAME"
      #   chef.validation_key_path = "ORGNAME-validator.pem"
      # end
      #
      # If you're using the Opscode platform, your validator client is
      # ORGNAME-validator, replacing ORGNAME with your organization name.
      #
      # If you have your own Chef Server, the default validation client name is
      # chef-validator, unless you changed the configuration.
      #
      #   chef.validation_client_name = "ORGNAME-validator"
      machine.vm.provision :shell,
        path: "vagrant-libs/bootstrap.sh"
    end
  end
end
