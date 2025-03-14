{
  description = "An example repo for Lanzaboote on AArch64 (Rock 5B)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    lanzaboote.url = "github:nix-community/lanzaboote";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, lanzaboote }: {

    nixosConfigurations.oceanrock = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";

      modules = [
        ./configuration.nix

        lanzaboote.nixosModules.lanzaboote
      ];
    };
  };
}
