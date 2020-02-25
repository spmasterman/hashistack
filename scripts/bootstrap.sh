#!/bin/bash
set -x

echo "Boostrapping server..."

sudo timedatectl set-timezone UTC

echo "Performing updates and installing prerequisites"

sudo apt-get -qq -y update
sudo apt-get install -qq -y unzip dnsutils ruby rubygems ntp nodejs npm nginx jq dnsmasq-base dnsmasq

sudo hostnamectl set-deployment development