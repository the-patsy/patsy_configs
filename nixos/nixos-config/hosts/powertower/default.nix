{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];
  boot.initrd.luks.devices."luks-71c88ff4-8f30-467a-8575-d1ab7a298a55".device = "/dev/disk/by-uuid/71c88ff4-8f30-467a-8575-d1ab7a298a55";
  users.users.patsy = {
  extraGroups = [ "input" "video" ];
};

  networking.hostName = "powertower"; # Define your hostname.

  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;  # needed for Steam on 64-bit systems

  #HDD
  boot.initrd.luks.devices."HDD" = {
    device = "/dev/disk/by-uuid/4f079a20-9b3f-49ed-8863-bbdb7638cabc";
    keyFile = "/etc/secrets/HDD.key";
    allowDiscards = true;
  };

  # HOTAS Setup
  services.udev.extraRules = ''
   #VKB Gladiator EVO R - hidraw access for Wine/Proton
  SUBSYSTEM=="hidraw", ATTRS{idVendor}=="231d", ATTRS{idProduct}=="0200", MODE="0660", GROUP="input"

   #Thrustmaster TWCS Throttle - hidraw access for Wine/Proton
  SUBSYSTEM=="hidraw", ATTRS{idVendor}=="044f", ATTRS{idProduct}=="b687", MODE="0660", GROUP="input"
'';

  # VR Setup
  security.rtkit.enable = true;

 # security.wrappers.vrcompositor-launcher = {
   # owner = "root";
  #  group = "root";
 #   capabilities = "cap_sys_nice+eip";
#    source = "/home/patsy/.local/share/Steam/steamapps/common/SteamVR/bin/linux64/vrcompositor-launcher";
#  };

  # Keyboard software
  hardware.ckb-next.enable = true;

  #Mount
  fileSystems."/home/patsy/HDD" = {
    device = "/dev/mapper/HDD";
    fsType = "btrfs";
    options = [ "defaults" "nofail" ];
  };
} 
