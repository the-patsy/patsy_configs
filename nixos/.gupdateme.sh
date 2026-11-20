#!/bin/bash/
cd /home/patsy/HDD/Documents/my_notes
git pull
cd -
cd /home/patsy/HDD/opt/patsy_configs
git pull
cd -
cd /home/patsy/HDD/opt/homepage
git pull
cd -
cd /home/patsy/HDD/opt/patsy_configs/nixos/nixos-config/
sudo nix flake update
sudo nixos-rebuild switch --flake /home/patsy/HDD/opt/patsy_configs/nixos/nixos-config#powertower-gaming
sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations +5
sudo nix-collect-garbage
tempdate=$(date +%F| tee /dev/tty)
git add .
git commit -m "update $tempdate"
git push
cd ~
