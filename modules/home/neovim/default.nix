# TODO:
# - prosemode
#   - \- => en dash (en dash)- => em dash
#   - wrapping?
#   <!-- - show wc (or at least get it easily) -->
#   - get wc (general?) (map \<leader>wc?)
#   - gj/gk maps??
#     - might be confusing/make bad habits
#
# - TS
#   - md
#     - indentation(?)
#
# - TODOs
#   - plugin probably suffices?
{
  imports = [
    ./plugins.nix
  ];

  programs.neovim = {
    enable = true;

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraLuaConfig = 'doFile ${./default.lua}';
  };
}
