#!/bin/bash
set -x

echo "Installing Docker"
curl -sSL https://get.docker.com/ | sudo sh

sudo sh -c "echo \"DOCKER_OPTS='--dns 127.0.0.1 --dns 8.8.8.8 --dns-search service.consul'\" >> /etc/default/docker"

sudo systemctl enable docker
sudo systemctl start docker

echo "Complete"