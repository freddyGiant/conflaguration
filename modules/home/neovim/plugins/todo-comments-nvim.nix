{ config, pkgs, ... }: {
  programs.neovim.plugins = [
    (config.lib.neovim.plugins.configFromFile "todo-comments-nvim")

    pkgs.vimPlugins.plenary-nvim # dependency
  ];
};

