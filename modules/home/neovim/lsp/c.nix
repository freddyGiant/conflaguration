{ config, lib, pkgs, ... }: {
  home.packages = [ pkgs.clang-tools ];
  programs.neovim.initLua = config.lib.neovim.order.mkLsp /* lua */ ''
    vim.lsp.enable 'clangd'
  '';
}
