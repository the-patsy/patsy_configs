#!/usr/bin/env bash

# Update script for my configs

# Flatpak updates
sudo flatpak update

# Update important repositories
cd ~/Documents/my_notes
git pull
cd -
cd ~/opt/homepage
git pull
cd -

# Package updates
sudo yum update
sudo yum upgrade -y
sudo yum autoremove
