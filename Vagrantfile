# vagrant init hashicorp/precise64
Vagrant.configure(2) do |config|
  config.vm.box = "puppetlabs/ubuntu-14.04-64-puppet"
  
  config.librarian_puppet.puppetfile_dir = "puppet"
  config.librarian_puppet.placeholder_filename = ".MYPLACEHOLDER"
  config.librarian_puppet.use_v1_api = '1'
  config.librarian_puppet.destructive = false


  # Puppet configs
  config.vm.provision "puppet" do |puppet|
  	puppet.manifests_path = "puppet/manifests"
  	puppet.manifest_file = "default.pp"

  	puppet.module_path = "puppet/modules"
  end

  # Port forwarders
  config.vm.network :forwarded_port, guest: 80, host: 3080
  config.vm.network :forwarded_port, guest: 4567, host: 4567
end
