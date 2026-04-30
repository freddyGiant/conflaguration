{ config, lib, pkgs, ... }: {
  home.packages = [ pkgs.nil ];
  programs.neovim.extraLuaConfig = config.lib.neovim.order.mkLsp /* lua */ ''
    vim.lsp.enable 'nil'
  '';
}
