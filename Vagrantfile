# vagrant init hashicorp/precise64
Vagrant.configure(2) do |config|
  config.vm.box = "puppetlabs/ubuntu-14.04-64-puppet"

  # Puppet configs
  config.vm.provision "puppet" do |puppet|
	puppet.manifests_path = "puppet/manifests"
	puppet.manifest_file = "default.pp"

	puppet.module_path = "puppet/modules"
  end

  config.vm.network :forwarded_port, guest: 80, host: 3000
end


