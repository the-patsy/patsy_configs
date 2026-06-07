{ config, pkgs, ... }:

{
  boot.initrd.luks.devices."luks-091aad14-94e8-4ef8-b53a-1493f3dfe3b6".device = "/dev/disk/by-uuid/091aad14-94e8-4ef8-b53a-1493f3dfe3b6";

  networking.hostName = "s76"; # Define your hostname.
  boot.kernelPackages = pkgs.linuxPackages_latest;
hardware.graphics.enable = true;
hardware.graphics.enable32Bit = true;  # needed for Steam on 64-bit systems

# NVIDIA
services.xserver.videoDrivers = [ "nvidia" ];

hardware.nvidia = {
  modesetting.enable = true;
  powerManagement.enable = false;
  open = false;          # use proprietary driver, not open-source kernel module
  nvidiaSettings = true;
  package = config.boot.kernelPackages.nvidiaPackages.stable;
};

#HDD
boot.initrd.luks.devices."HDD" = {
  device = "/dev/disk/by-uuid/608da6ed-cb75-400b-ad6f-74379eefb4c1";
  keyFile = "/etc/secrets/HDD.key";
  allowDiscards = true;
};

#Mount
fileSystems."/home/patsy/mnt/HDD" = {
  device = "/dev/mapper/HDD";
  fsType = "ext4";
  options = [ "defaults" "nofail" ];
};
}
