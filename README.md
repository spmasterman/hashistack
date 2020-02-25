# Hashistack

Nomad, Consul and Vault built on a Vagrant VM.

Typically I use this as a "starter" for use in other projects, i.e. detach from the repository, edit the vagrantfile 
for use in that project, etc.

#### 1. Install vagrant and virtualbox ####

`brew cask install vagrant`

`brew cask install virtualbox` 

optionally

`brew cask install vagrant-manager`

#### 2. Clone repo ####

`git clone <repo> platform`

detach from git

`rm -rf platform/.git`

(optionally add /platform to host projects .gitignore)

Edit vagrant file to suit (port mappings, cpu, memory etc).  

#### 3. Up ####

`vagrant up`

Interact from the command line 

`nomad plan myjob.nomad` etc

#### 4. Cleanup ####

`vagrant halt && vagrant destroy`