{
  description = "patsy NixOS configs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      mkHost = { host, system ? "x86_64-linux", extraModules ? [] }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./modules/common.nix
            ./hosts/${host}/default.nix
          ] ++ extraModules;
        };
    in {
      nixosConfigurations = {
        # Normal configs — built into day-to-day use
        powertower = mkHost { host = "powertower"; };
        s76        = mkHost { host = "s76"; };
        ultra      = mkHost { host = "ultra"; };

        # Gaming variants — only for hosts that make sense
        powertower-gaming = mkHost { host = "powertower"; extraModules = [ ./modules/gaming.nix ]; };
        s76-gaming        = mkHost { host = "s76";        extraModules = [ ./modules/gaming.nix ]; };

        # Pentest variants — all three hosts
        powertower-pentest = mkHost { host = "powertower"; extraModules = [ ./modules/pentest.nix ]; };
        s76-pentest        = mkHost { host = "s76";        extraModules = [ ./modules/pentest.nix ]; };
        ultra-pentest      = mkHost { host = "ultra";      extraModules = [ ./modules/pentest.nix ]; };
      };
    };
}