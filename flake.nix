{
  description = "A Vradical New Configuration Conflagaration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    conflaguration-secrets.flake = true;
  };

  outputs = { nixpkgs, home-manager, ... } @ inputs: let
    lib = nixpkgs.lib;

    nixpkgsSettings = { config.allowUnfree = true; };

    mkSystems = lib.mkMerge;

    mkNixos = hostname: {
      nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          nixpkgsSettings
          home-manager.nixosModules.home-manager

          ./hosts/${hostname}/
          { networking.hostName = hostname; }
          ./modules/nixos/
        ];
      };
    };
  in mkSystems
  [
    (mkNixos "tranticicero")
  ];
}
