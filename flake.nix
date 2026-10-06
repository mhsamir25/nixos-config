{
  description = "Samir's NixOS Flake Configuration";

  inputs = {
    nixpkgs.url = "git+https://github.com/NixOS/nixpkgs.git?ref=nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # --- ADD THIS BLOCK ---
colorshell = {
      url = "github:retrozinndev/colorshell/154a10a";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # ----------------------
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: { # <- Make sure `@inputs` is here
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        # --- ADD THIS LINE ---
        specialArgs = { inherit inputs; };
        # ---------------------

        modules = [
          ./hosts/laptop/hardware-configuration.nix
          ./hosts/laptop/configuration.nix

          home-manager.nixosModules.home-manager
        ];
      };
    };
  };
}
