{
  description = "A Vradical New Configuration Conflagaration";

  inputs = {
    nixpkgs.follows = "nixpkgs-unstable";
    # to be overriden
    secret-settings.url = "";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.    url = "github:nix-community/home-manager";
    flake-parts.     url = "github:hercules-ci/flake-parts";
    rad-flake.       url = "github:freddyGiant/rad-flake";
    niri.            url = "github:sodiboo/niri-flake";

    home-manager.inputs.nixpkgs.    follows = "nixpkgs";
    flake-parts. inputs.nixpkgs-lib.follows = "nixpkgs-unstable";
    rad-flake.   inputs.flake-parts.follows = "flake-parts";
    niri.        inputs.nixpkgs.    follows = "nixpkgs";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } (
      { config, lib, inputs, ... }: {
        imports = [
          inputs.flake-parts.flakeModules.modules
          # inputs.rad-flake.flakeModules.default

          ./modules/hosts/tranticicero
        ];

        perSystem = { pkgs, ... }: {
          formatter = pkgs.nixfmt-tree;
        };
      }
    );

  # outputs = { nixpkgs, home-manager, secret-settings, ... } @ inputs: let
  #   lib = nixpkgs.lib;
  #
  #   mkSystems = builtins.foldl' lib.recursiveUpdate {};
  #
  #   specialArgs = { inherit inputs; };
  #   mkNixos = hostname: {
  #     nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
  #       inherit specialArgs;
  #       modules = [
  #         { networking.hostName = hostname; }
  #         ./hosts/${hostname}
  #
  #         ./modules/nixos
  #         (secret-settings.nixosModule or {})
  #         home-manager.nixosModules.home-manager
  #       ];
  #     };
  #   };
  # in mkSystems
  # [
  #   (mkNixos "tranticicero")
  #   (mkNixos "homonculus")
  # ];
}
