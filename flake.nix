{
  description = "Samir's NixOS Flake Configuration";

  # INPUTS: External dependencies used by this configuration.
  inputs = {
    nixpkgs.url = "git+https://github.com/NixOS/nixpkgs.git?ref=nixos-26.05";
  };

  # OUTPUTS: Configurations that this flake can build.
  outputs = { self, nixpkgs, ... }@inputs: {

    # NixOS configurations available from this flake.
    nixosConfigurations = {

      # "nixos" is the name of this configuration.
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        # Configuration files used to build the system.
        modules = [
          ./hosts/laptop/hardware-configuration.nix
          ./hosts/laptop/configuration.nix
        ];
      };
    };
  };
}
