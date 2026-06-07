#!/bin/bash/
cd /home/patsy/Documents/my_notes
git pull
cd -
cd /home/patsy/opt/patsy_configs
git pull
cd -
cd /home/patsy/opt/homepage
git pull
cd -
sudo nixos-rebuild switch --flake ~/home/path/to/#flake --upgrade-all
sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations +5
sudo nix-collect-garbage
