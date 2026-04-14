{
  description = "A Vradical New Configuration Conflagaration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri.url = "github:sodiboo/niri-flake";

    # to be overriden
    secrets.url = "";
  };

  outputs = { nixpkgs, home-manager, niri, secrets, ... } @ inputs: let
    lib = nixpkgs.lib;

    mkSystems = lib.mkMerge;

    specialArgs = {
      inherit inputs niri secrets;
      conflagurationPath = ./.;
    };
    mkNixos = hostname: {
      nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        modules = [
          ./hosts/${hostname}/
          ./modules/nixos/
          { networking.hostName = hostname; };

          home-manager.nixosModules.home-manager
        ];
      };
    };
  in mkSystems
  [
    (mkNixos "tranticicero")
  ];
}
