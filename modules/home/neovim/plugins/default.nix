{ pkgs, ... }: let
  inherit (import ./lib.nix) pluginConfigFromFile;
in {
  imports = [ ./leap-nvim.nix ];

  programs.neovim.plugins = map pluginConfigFromFile [
    "gruvbox-material-nvim"
    "blink-cmp"
  ];
}
