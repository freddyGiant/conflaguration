{ config, pkgs, ... }: {
  programs.neovim.plugins = [
    (config.lib.neovim.plugins.configFromFile "leap-nvim")

    pkgs.vimPlugins.vim-repeat # dependency
  ];
};

