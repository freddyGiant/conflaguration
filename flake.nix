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

  outputs = { nixpkgs, home-manager, secret-settings, ... } @ inputs: let
    lib = nixpkgs.lib;

    mkSystems = builtins.foldl' lib.recursiveUpdate {};

    specialArgs = {
      # NOTE: should secret-settings be replaced with secretSettingsPath?
      inherit inputs;
      conflagurationPath = ./.;
    };
    mkNixos = hostname: {
      nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        modules = [
          { networking.hostName = hostname; }
          ./hosts/${hostname}

          ./modules/nixos
          (secret-settings.nixosModule or {})
          home-manager.nixosModules.home-manager
        ];
      };
    };
  in mkSystems
  [
    (mkNixos "tranticicero")
    (mkNixos "homonculus")
  ];
}
