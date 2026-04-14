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
