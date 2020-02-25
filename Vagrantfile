# -*- mode: ruby -*-
# vi: set ft=ruby :

# DHCP patch issue - not sure whats happening
# https://github.com/hashicorp/vagrant/issues/8878
class VagrantPlugins::ProviderVirtualBox::Action::Network
  def dhcp_server_matches_config?(dhcp_server, config)
    true
  end
end

# Networking
private_ip = ENV['PRIVATE_IP'] || "192.168.50.150"
consul_host_port = ENV['CONSUL_HOST_PORT'] || 8500
vault_host_port = ENV['VAULT_HOST_PORT'] || 8200
nomad_host_port = ENV['NOMAD_HOST_PORT'] || 4646

# Base box selection
base_box = ENV['BASE_BOX'] || "ubuntu/bionic64"

# Consul variables
consul_version = ENV['CONSUL_VERSION'] || "1.6.3"
consul_ent_url = ENV['CONSUL_ENT_URL']
consul_group = "consul"
consul_user = "consul"
consul_comment = "Consul"
consul_home = "/srv/consul"

# Vault variables
vault_version = ENV['VAULT_VERSION'] || "1.3.2"
vault_ent_url = ENV['VAULT_ENT_URL']
vault_group = "vault"
vault_user = "vault"
vault_comment = "Vault"
vault_home = "/srv/vault"

# Nomad variables
nomad_version = ENV['NOMAD_VERSION'] || "0.10.4"
nomad_ent_url = ENV['NOMAD_ENT_URL']
nomad_group = "root"
nomad_user = "root"

Vagrant.configure("2") do |config|

  # Setup networking
  config.vm.network :private_network, ip: private_ip
  config.vm.network :forwarded_port, guest: 8500, host: consul_host_port, auto_correct: true
  config.vm.network :forwarded_port, guest: 8200, host: vault_host_port, auto_correct: true
  config.vm.network :forwarded_port, guest: 4646, host: nomad_host_port, auto_correct: true
  config.vm.network "private_network", type: "dhcp"

  # Use base_box set at the top of this file
  config.vm.box = base_box
  config.vm.hostname = "fourchimps"

  # Bootstrap the box
  config.vm.provision "shell", inline: "/vagrant/scripts/bootstrap.sh"

  # Setup Consul User
  config.vm.provision "shell", inline: "/vagrant/scripts/create_user.sh", env: {
      "GROUP" => consul_group,
      "USER" => consul_user,
      "COMMENT" => consul_comment,
      "HOME" => consul_home
    }

  # Install Consul
  config.vm.provision "shell", inline: "/vagrant/scripts/install_consul.sh", env: {
    "VERSION" => consul_version,
    "URL" => consul_ent_url,
    "USER" => consul_user,
    "GROUP" => consul_group,
  }

  # Setup Vault user
  config.vm.provision "shell", inline: "/vagrant/scripts/create_user.sh", env: {
      "GROUP" => vault_group,
      "USER" => vault_user,
      "COMMENT" => vault_comment,
      "HOME" => vault_home,
    }

  # Install Vault
  config.vm.provision "shell", inline: "/vagrant/scripts/install_vault.sh", env: {
      "VERSION" => vault_version,
      "URL" => vault_ent_url,
      "USER" => vault_user,
      "GROUP" => vault_group,
    }

  # Install Nomad
  config.vm.provision "shell", inline: "/vagrant/scripts/install_nomad.sh", env: {
     "VERSION" => nomad_version,
     "URL" => nomad_ent_url,
     "USER" => nomad_user,
     "GROUP" => nomad_group,
   }

  # Increase memory for Virtualbox
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
  end

  # Cleanup
  config.vm.provision "shell", inline: "/vagrant/scripts/cleanup.sh"

  config.vm.post_up_message = "
     Consul: http://#{private_ip}:#{consul_host_port}/
     Vault: http://#{private_ip}:#{vault_host_port}/
     Nomad: http://#{private_ip}:#{nomad_host_port}/
     Vault Root Token: #{vault_home}/.vault-token/
  "

end