# vagrant init hashicorp/precise64
Vagrant.configure(2) do |config|
  config.vm.box = "hashicorp/precise64"
  config.vm.provision "puppet"
  config.vm.network :forwarded_port, guest: 80, host: 3000
end


