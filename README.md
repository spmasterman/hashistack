# Hashistack

Nomad, Consul and Vault built on a Vagrant VM.

#### 1. Install vagrant and virtualbox ####

`brew cask install vagrant`

`brew cask install virtualbox` 

optionally

`brew cask install vagrant-manager`

#### 2. Clone repo ####

#### 3. Up ####

`vagrant up`

Interact from the command line 

`nomad plan myjob.nomad` etc

#### 4. Cleanup ####

`vagrant halt && vagrant destroy`