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
    secret-settings.url = "";
  };

  outputs = { nixpkgs, home-manager, niri, secret-settings, ... } @ inputs: let
    lib = nixpkgs.lib;

    mkSystems = lib.mkMerge;

    specialArgs = {
      inherit inputs niri secret-settings;
      conflagurationPath = ./.;
    };
    mkNixos = hostname: {
      nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        modules = [
          ./hosts/${hostname}
          # TODO: Consider adding lib
          # TODO: consider optionality of secret-settings
          ./modules/nixos
          { networking.hostName = hostname; }

          home-manager.nixosModules.home-manager
        ];
      };
    };
  in mkSystems
  [
    (mkNixos "tranticicero")
  ];
}
