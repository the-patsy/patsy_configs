{ config, pkgs, ... }:

{
  boot.initrd.luks.devices."luks-5858d6fe-f2d9-4528-b9f4-ca3831800984".device = "/dev/disk/by-uuid/5858d6fe-f2d9-4528-b9f4-ca3831800984";
  networking.hostName = "ultrabook";
}
