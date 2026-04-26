{ pkgs, ... }: let
  # inherit (import ./lib.nix) pluginConfigFromFile;
  pluginConfigFromFile = (import ./lib.nix).pluginConfigFromFile pkgs;
in {
  imports = [
    ./leap-nvim.nix
    ./todo-comments-nvim.nix
  ];

  programs.neovim.plugins = map pluginConfigFromFile [
    "gruvbox-material-nvim"
    "blink-cmp"
  ];
}
