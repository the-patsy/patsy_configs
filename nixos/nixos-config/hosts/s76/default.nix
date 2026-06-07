{ config, pkgs, ... }:

{
  boot.initrd.luks.devices."luks-091aad14-94e8-4ef8-b53a-1493f3dfe3b6".device = "/dev/disk/by-uuid/091aad14-94e8-4ef8-b53a-1493f3dfe3b6";

  networking.hostName = "nixos"; # Define your hostname.

}
