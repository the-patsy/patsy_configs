{
  description = "patsy NixOS configs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {

    nixosConfigurations = {

      powertower = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./modules/common.nix
          ./hosts/powertower/default.nix
          ./hosts/powertower/hardware-configuration.nix
        ];
      };

      s76 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./modules/common.nix
          ./hosts/s76/default.nix
          ./hosts/s76/hardware-configuration.nix
        ];
      };

    };
  };
}
