{ config, pkgs, ... }: {
  imports = [
    ./leap-nvim.nix
    ./todo-comments-nvim.nix
  ];

  lib.neovim.plugins.configFromFile = pkgs: name: {
    plugin = pkgs.vimPlugins.${name};
    type = "lua";
    config = builtins.readFile ./${name};
  };

  programs.neovim.plugins = map config.lib.neovim.plugins.configFromFile [
    "gruvbox-material-nvim"
    "blink-cmp"
  ];
}
