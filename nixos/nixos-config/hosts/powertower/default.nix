{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];
  boot.initrd.luks.devices."luks-38a4207f-6ae6-4333-8e9e-6d8cbe258ac0".device = "/dev/disk/by-uuid/38a4207f-6ae6-4333-8e9e-6d8cbe258ac0";
  users.users.patsy = {
  extraGroups = [ "input" ];
};
  networking.hostName = "powertower"; # Define your hostname.

  boot.kernelPackages = pkgs.linuxPackages_6_12;
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;  # needed for Steam on 64-bit systems
# NVIDIA
services.xserver.videoDrivers = [ "nvidia" ];
nixpkgs.config.nvidia.acceptLicense = true;
hardware.nvidia = {
  modesetting.enable = true;
  powerManagement.enable = false;
  open = false;          # use proprietary driver, not open-source kernel module
  nvidiaSettings = true;
  package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
};

#HDD
boot.initrd.luks.devices."HDD" = {
  device = "/dev/disk/by-uuid/4f079a20-9b3f-49ed-8863-bbdb7638cabc";
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
