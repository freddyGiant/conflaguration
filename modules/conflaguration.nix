# the bones of it all
{ lib, ... }:
let
  inherit (lib) types;
in
{
  options.conflaguration.modules = lib.mkOption {
    type = types.lazyAttrsOf (
      types.submodule (
        { name, ... }:
        let
          withClass =
            class:
            lib.mkOption {
              type = types.deferredModule;
              default = { };
              apply = m: { ... }: {
                _class = class;
                _file = "conflaguration.modules.${name}.${class}";
                imports = [ m ];
              };
            };
        in
        {
          options.nixos = withClass "nixos";
          options.homeManager = withClass "homeManager";
        }
      )
    );
    default = { };
  };
}
