{ config, pkgs, ... }:

{
  boot.initrd.luks.devices."luks-38a4207f-6ae6-4333-8e9e-6d8cbe258ac0".device = "/dev/disk/by-uuid/38a4207f-6ae6-4333-8e9e-6d8cbe258ac0";

  networking.hostName = "powertower"; # Define your hostname.

hardware.graphics.enable = true;
hardware.graphics.enable32Bit = true;  # needed for Steam on 64-bit systems

#HDD
boot.initrd.luks.devices."HDD" = {
  device = "/dev/disk/by-uuid/c13b1aa8-dcde-499b-900d-9f59856f4f63";
  keyFile = "/etc/secrets/HDD.key";
  allowDiscards = true;
};

#Mount
fileSystems."/home/patsy/HDD" = {
  device = "/dev/mapper/HDD";
  fsType = "btrfs";
  options = [ "defaults" "nofail" ];
  };
}
