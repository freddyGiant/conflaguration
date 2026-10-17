{ lib, config, inputs, options, ... }:
let
  inherit (lib) mkOption types;

  cfg = config.conflaguration;
  opt = options.conflaguration;
in
{
  options.conflaguration = 
  let
    mkFeatureOption = class: label: mkOption {
      type = types.deferredModule;
      default = { };
      apply = m:
        { ... }:
        {
          _class = class;
          _file = "${label} for ${class}";
          imports = [ m ];
        };
    };
  in
  {
    username = mkOption { type = types.str; };

    features = mkOption {
      default = { };
      type = types.lazyAttrsOf (types.submodule ({ name, ... }: {
        options = {
          nixos       = mkFeatureOption "nixos"       "conflaguration feature ${name}";
          # darwin      = mkFeatureOption "darwin"      "conflaguration feature ${name}";
          homeManager = mkFeatureOption "homeManager" "conflaguration feature ${name}";
        };
      }));
    };

    hosts = mkOption {
      default = { };
      type = types.attrsOf (types.submodule ({ name, ... }: {
        options = {
          system = mkOption { type = types.enum lib.systems.flakeExposed; };

          myUser = mkOption {
            type = opt.username.type;
            default = cfg.username;
          };

          features = mkOption {
            type = types.listOf (types.enum (lib.attrNames cfg.features));
            default = [ ];
          };

          # TODO: could be rearranged along with the base features to not have any invariants
          class = mkOption {
            type = types.enum [
              "nixos"
              # "darwin"
              # "homeManager"
            ];
          };

          nixos       = mkFeatureOption "nixos"       "conflaguration host ${name} base module";
          # darwin      = mkFeature "darwin"      "conflaguration host ${name} base module";
          homeManager = mkFeatureOption "homeManager" "conflaguration host ${name} base module";
        };
      }));
    };
  };

  config.flake =
  let
    filterClass = class: lib.filterAttrs (_: x: x.class == class);
  in
  {
    nixosConfigurations = lib.mapAttrs (hostname: host:
      inputs.nixpkgs.lib.nixosSystem {
        modules = [
          host.nixos
          {
            imports = filterClass "nixos" cfg.features;
            networking.hostName = hostname;
            nixpkgs.hostPlatform = host.system;

            i18n.defaultLocale = "C.UTF-8";

            nixpkgs.config.allowUnfree = true;
            nix.settings.experimental-features = [
              "nix-command"
              "pipe-operators"
              "flakes"
            ];
          }

          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${cfg.username}.imports =
              [ host.homeManager ] ++ (filterClass "homeManager" cfg.features);
          }
        ];
      }
    ) (filterClass "nixos" cfg.hosts);

    # darwinConfigurations = lib.mapAttrs (name: host:
    #   inputs.nix-darwin.lib.darwinSystem {
    #     modules = [
    #       inputs.home-manager.darwinModules.home-manager
    #       (homeManagerOs name host)
    #       {
    #         networking.hostName = name;
    #         nixpkgs.hostPlatform = host.system;
    #       }
    #       host.darwin
    #     ] ++ map (f: f.darwin) (featuresOf name host);
    #   }
    # ) (hostsOf "darwin");
    #
    # homeConfigurations = lib.mapAttrs (name: host:
    #   inputs.home-manager.lib.homeManagerConfiguration {
    #     pkgs = inputs.nixpkgs.legacyPackages.${host.system};
    #     modules = [
    #       { home.username = lib.mkDefault cfg.username; }
    #       host.homeManager
    #     ] ++ map (f: f.homeManager) (featuresOf name host);
    #   }
    # ) (hostsOf "homeManager");
  };
}
