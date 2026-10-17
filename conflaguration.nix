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
    username = mkOption {
      default = "vrad";
      type = lib.types.strMatching "^[a-z_]([a-z0-9_-]{0,31}|[a-z0-9_-]{0,30}\$)$";
    };

    features = mkOption {
      default = { };
      type = types.lazyAttrsOf (types.submodule ({ name, ... }: {
        options = {
          nixos       = mkFeatureOption "nixos"       "conflaguration feature ${name}";
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

          class = mkOption {
            type = types.enum [
              "nixos"
            ];
          };

          nixos       = mkFeatureOption "nixos"       "conflaguration host ${name} base module";
          homeManager = mkFeatureOption "homeManager" "conflaguration host ${name} base module";
        };
      }));
    };
  };

  config.flake =
  let
    featuresOfClass = class: map (f: cfg.features.${f}.${class});
    hostsOfClass = class: lib.filterAttrs (_: h: h.class == class) cfg.hosts;
  in
  {
    nixosConfigurations =
      hostsOfClass "nixos"
      |> lib.mapAttrs (
        hostname: host:
        inputs.nixpkgs.lib.nixosSystem { modules = [
          host.nixos
          {
            imports = featuresOfClass "nixos" host.features;
            networking.hostName = hostname;
            nixpkgs.hostPlatform = host.system;
            users.users.${host.myUser}.isNormalUser = true;

            i18n.defaultLocale = "C.UTF-8";

            nixpkgs.config.allowUnfree = true;
            nix.settings.experimental-features = [
              "nix-command"
              "pipe-operators"
              "flakes"
            ];
            system.stateVersion = "25.11";
          }

          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.users.${host.myUser} = {
              imports = [
                host.homeManager
                { imports = featuresOfClass "homeManager" host.features; }
              ];

              home.stateVersion = "25.11";
            };

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
        ]; }
      );
  };
}
