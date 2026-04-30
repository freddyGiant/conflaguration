# TODO:
# - prosemode
#   - \- => en dash (en dash)- => em dash
#   - wrapping?
#   <!-- - show wc (or at least get it easily) -->
#   - get wc (general?) (map \<leader>wc?)
#
# - TS
#   - md
#     - indentation(?)
#
# - TODOs
#   - plugin probably suffices?
{ config, lib, ... }: {
  imports = [
    ./lsp/
    ./plugins/
    ./treesitter.nix
  ];

  programs.neovim.enable = true;
  programs.neovim = {
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  # lib.neovim.order = lib.mkForce {
  #   default = 1000;
  #   treesitter = 2000;
  #   lsp = 3000;
  #   mkOtherPlugins = 8000;
  # }

  programs.neovim.extraLuaConfig = builtins.readFile ./default.lua;

  lib.neovim.order = {
    lsp = 3000;
    mkLsp = lib.mkOrder config.lib.neovim.order.lsp;
  };
}
