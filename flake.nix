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
      nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem { modules = [
        nixpkgsSettings

        ./hosts/${hostname}/

        {
          networking.hostName = hostname;
        }

        ./modules/nixos/

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
        }

        # ./modules/home/
      ]; };
    };
  in mkSystems
  [
    (mkNixos "tranticicero")
  ];
}
