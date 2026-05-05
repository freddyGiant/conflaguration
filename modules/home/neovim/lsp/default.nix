{ config, lib, pkgs, ... }: let
  mkBeforeLsp = lib.mkOrder (config.lib.neovim.order.lsp - 500);
in {
  programs.neovim.plugins = [ pkgs.vimPlugins.nvim-lspconfig ];
  programs.neovim.initLua = mkBeforeLsp /* lua */ ''
    -- NVIM-LSPCONFIG
    vim.lsp.config('*', { root_markers = { '.git' }, })

    local group = vim.api.nvim_create_augroup('vrad.lsp.on_attach', {})

    ---@param name string '*', or string matching `name` field of lsp client
    ---@param fn fun(event: table, client: vim.lsp.Client) what to do on attach (see :help event-args)
    local function on_attach(name, fn)
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)

          if client and (name == '*' or client.name == name) then
            fn(event, client)
          end
        end,
        group = group,
      })
    end

    on_attach('*', function(event, client)
        -- disable lsp highlighting
      client.server_capabilities.semanticTokensProvider = nil

      vim.keymap.set('n', [[gd]], vim.lsp.buf.definition, { buffer = event.buf, })
      vim.keymap.set('n', [[gD]], vim.lsp.buf.declaration, { buffer = event.buf, })
      vim.keymap.set('n', [[<leader>d]], vim.lsp.buf.type_definition, { buffer = event.buf, })
    end)
  '';
}
