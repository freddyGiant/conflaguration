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
        ./modules/nixos/

        {
          networking.hostName = hostname;
        }


        home-manager.nixosModules.home-manager
      ]; };
    };
  in mkSystems
  [
    (mkNixos "tranticicero")
  ];
}
