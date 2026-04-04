{ pkgs, ... }: let
  inherit (import ./lib.nix) pluginConfigFromFile;
in {
  programs.neovim.plugins = [
    (pluginConfigFromFile "leap-nvim")

    pkgs.vimPlugins.vim-repeat # dependency
  ];
};

