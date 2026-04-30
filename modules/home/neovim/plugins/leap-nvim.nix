{ config, pkgs, ... }: {
  programs.neovim.plugins = [
    (config.lib.neovim.plugins.fromFile "leap-nvim")

    pkgs.vimPlugins.vim-repeat # dependency
  ];
};

