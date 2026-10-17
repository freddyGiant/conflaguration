{ config, pkgs, ... }: {
  imports = [
    ./leap-nvim.nix
    ./todo-comments-nvim.nix
  ];

  lib.neovim.plugins.fromFile = name: {
    plugin = pkgs.vimPlugins.${name};
    type = "lua";
    config = builtins.readFile ./${name}.lua;
  };

  programs.neovim.plugins = map config.lib.neovim.plugins.fromFile [
    "gruvbox-material-nvim"
    "blink-cmp"
  ];
}
