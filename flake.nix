{
  description = "A Vradical New Configuration Conflagaration";

  inputs = {
    nixpkgs.follows = "nixpkgs-unstable";
    # to be overriden
    secret-settings.url = "";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    flake-parts.url = "github:hercules-ci/flake-parts";
    rad-flake.url = "github:freddyGiant/rad-flake";
    niri.url = "github:sodiboo/niri-flake";

    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs-unstable";
    rad-flake.inputs.flake-parts.follows = "flake-parts";
    niri.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } (
      {
        config,
        lib,
        inputs,
        ...
      }:
      {
        imports = [
          ./conflaguration.nix
          ./hosts/homonculus
        ];

        systems = lib.systems.flakeExposed;
        perSystem = { pkgs, ... }: {
          formatter = pkgs.nixfmt-tree;
        };
      }
    );
}
