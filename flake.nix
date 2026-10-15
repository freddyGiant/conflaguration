{
  description = "A Vradical New Configuration Conflagaration";

  inputs.nixpkgs.url = "nixpkgs/nixos-unstable"; # alias
  # inputs.nixpkgs-unstable.url = "nixpkgs/nixos-unstable"; # use this to be explicit
  inputs.flake-parts.url = "github:hercules-ci/flake-parts";
  # inputs.rad-flake.url = "github:freddyGiant/rad-flake";

  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";

  inputs.niri.url = "github:sodiboo/niri-flake";

  # to be overriden
  inputs.secret-settings.url = "";

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } (
      { config, lib, inputs, ... }: {
        # imports = [
        #   inputs.rad-flake.flakeModules.default
        # ];

        config.lib.classOption = lib.mkOption {
          type = lib.types.lazyAttrsOf lib.types.deferredModule;
        };

        options.nixos = config.lib.classOption;
        options.home-manager = config.lib.classOption;

        perSystem = { pkgs-unstable, ... }: {
          formatter = pkgs-unstable.nixfmt-tree;
        };

        systems = [ "x86_64-linux" ];
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
