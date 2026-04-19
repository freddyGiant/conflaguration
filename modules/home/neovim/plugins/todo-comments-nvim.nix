{ pkgs, ... }: let
  inherit (import ./lib.nix) pluginConfigFromFile;
in {
  programs.neovim.plugins = [
    (pluginConfigFromFile "todo-comments-nvim")

    pkgs.vimPlugins.plenary-nvim # dependency
  ];
};

