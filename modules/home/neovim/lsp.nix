# TODO: separate languages into modules, perhaps even outside of neovim
# TODO: on_attach as shared library method.
#   - reconsider on_attach augroup.
# TODO: qmlls
{ pkgs, ... }: {
  programs.neovim = {
    plugins = [ pkgs.vimPlugins.nvim-lspconfig ];

    extraLuaConfig = /* lua */ "dofile '${./lsp.lua}'"
  };

  home.packages = with pkgs; [
    nil
    lua-language-server
    basedpyright
    clang-tools
  ];
}
