{ config, pkgs, ... }:

{
  boot.initrd.luks.devices."luks-38a4207f-6ae6-4333-8e9e-6d8cbe258ac0".device = "/dev/disk/by-uuid/38a4207f-6ae6-4333-8e9e-6d8cbe258ac0";

  networking.hostName = "powertower"; # Define your hostname.

}
