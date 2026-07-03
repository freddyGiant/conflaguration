# TODO:
# - CONSIDER an organization scheme that puts each language in its own file
#   - can use options for initlua and such so we don't have to export all those ordering functions
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
    ./lsp
    ./plugins
    ./treesitter.nix
  ];

  programs.neovim.enable = true;
  programs.neovim = {
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
  programs.neovim.withRuby = false; # stateVersion 25.11
  programs.neovim.withPython3 = false; # stateVersion 25.11

  programs.neovim.initLua = builtins.readFile ./default.lua;

  lib.neovim.order = {
    lsp = 3000;
    mkLsp = lib.mkOrder config.lib.neovim.order.lsp;
  };
}
