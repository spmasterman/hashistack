#!/bin/bash
set -x

echo "Running"

echo "Cleanup install artifacts"
sudo rm -rf /tmp/*

history -c

echo "Complete"