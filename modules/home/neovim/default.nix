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
{
  imports = [
    ./lsp.nix
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
  programs.neovim.extraLuaConfig = /* lua */ "doFile '${./default.lua}'";
}
