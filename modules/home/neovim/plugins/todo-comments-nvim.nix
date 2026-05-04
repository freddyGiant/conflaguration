{ config, pkgs, ... }: {
  programs.neovim.plugins = [
    (config.lib.neovim.plugins.fromFile "todo-comments-nvim")

    pkgs.vimPlugins.plenary-nvim # dependency
  ];
}
