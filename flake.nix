{
  description = "A Vradical New Configuration Conflagaration";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.flake-parts.url = "github:hercules-ci/flake-parts";
  inputs.rad-flake.url = "github:freddyGiant/rad-flake";

  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

  inputs.niri.url = "github:sodiboo/niri-flake";

  # to be overriden
  inputs.secret-settings.url = "";

  outputs = {
    flake-parts,
    rad-flake,
    ...
  }@inputs:
  flake-parts.lib.mkFlake { inherit inputs; } {
    imports = [
      rad-flake.flakeModules.default
      ./modules/nixos
      ./modules/home
    ];
  };

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
