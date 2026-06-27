{ config, pkgs, lib, ... }:

{
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-unwrapped"
  ];

  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
    gamescopeSession.enable = true;
  };
  hardware.steam-hardware.enable = true;

  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    lutris wineWow64Packages.stable winetricks mangohud jstest-gtk
  ];
}
