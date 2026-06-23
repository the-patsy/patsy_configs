{ config, pkgs, lib, ... }:

{
  # Bootloader (EFI — keep here since it's shared; LUKS moves to host)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #PiHole
  networking.networkmanager = {
    enable = true;
  };

  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver.xkb = { layout = "us"; variant = ""; };

  environment.pathsToLink = [ "/libexec" ];
  services.xserver = {
    enable = true;
    desktopManager.xterm.enable = false;
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [ dmenu i3status i3blocks ];
    };
  };
  services.displayManager.defaultSession = "none+i3";
  programs.i3lock.enable = true;

  users.users.patsy = {
    isNormalUser = true;
    description = "patsy";
    extraGroups = [ "networkmanager" "libvirtd" "wheel" "plugdev" ];
  };

  fonts.packages = with pkgs; [ nerd-fonts.hack ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = false;
      AllowUsers = null;
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "no";
    };
  };

# Nixld
programs.nix-ld = {
  enable = true;
  package = pkgs.nix-ld;
  libraries = [ pkgs.glibc pkgs.libGL pkgs.libx11 pkgs.libxi pkgs.libxext pkgs.libxrandr pkgs.libxrender pkgs.libxcursor pkgs.libxinerama ]; # Add other needed libraries here
};   

  nixpkgs.config.allowUnfree = true;

  # Packages installed
  environment.systemPackages = with pkgs; [
    vim wget brave gimp vlc openvpn libreoffice kitty obsidian
    qemu_kvm virt-manager thunderbird git kdePackages.dolphin
    polybar gcc flameshot python3 p7zip unzip zip mullvad pulseaudio htop
    feh mangohud bsdgames xdpyinfo gparted yubikey-manager networkmanagerapplet
    yubioath-flutter usbutils mesa-demos bind coreutils winetricks vscodium
  ];

  # Enable this by default. Supposedly just for steam.
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  # Yubikey
  services.pcscd.enable = true;
  services.udev.packages = [ pkgs.yubikey-personalization pkgs.libu2f-host ];

  services.mullvad-vpn.enable = true;
  services.pipewire.pulse.enable = true;

    environment.variables.SAL_USE_VCLPLUGIN = "gtk3";

    programs.bash = {
      enable = true;
      shellAliases = {
        l  = "ls -alh";
        ll = "ls -l";
        ls = "ls --color=tty";
        pupdateme = "bash /home/patsy/.pupdateme.sh";
        gupdateme = "bash /home/patsy/.gupdateme.sh";
      };
    };

    virtualisation.libvirtd = {
      enable = true;
      qemu.runAsRoot = false;
    };
    programs.virt-manager.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;

    security.polkit.enable = true;
    security.polkit.extraConfig = ''
      polkit.addRule(function(action, subject) {
        if (action.id == "org.libvirt.unix.manage" && subject.isInGroup("libvirtd")) {
        return polkit.Result.YES;
        }
      });
    '';

    system.stateVersion = "25.11";
}
