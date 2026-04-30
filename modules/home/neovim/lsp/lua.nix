{ config, lib, pkgs, ... }: {
  home.packages = [ pkgs.lua-language-server ];
  programs.neovim.extraLuaConfig = config.lib.neovim.order.mkLsp /* lua */ ''
    -- from comments in nvim-lspconfig/lsp/lua_ls.lua
    vim.lsp.config('lua_ls', {
      on_init = function(client)
        if client.workspace_folders then
          local path = client.workspace_folders[1].name

          -- we only want to include all the vim files if we *are* in $XDG_CONFIG_HOME/nvim and no local config is present
          if path ~= vim.fn.stdpath('config') and (
            ---@diagnostic disable-next-line: undefined-field
            vim.uv.fs_stat(path .. '/.luarc.json') or
            ---@diagnostic disable-next-line: undefined-field
            vim.uv.fs_stat(path .. '/.luarc.jsonc')
            -- why isn't fs_stat real
          ) then
            return
          end
        end

        -- include vim-related files
        client.config.settings.Lua = vim.tbl_deep_extend(
          'force',
          client.config.settings.Lua,
          {
            runtime = {
              -- neovim's runtime
              version = 'LuaJIT',

              -- (see `:h lua-module-load`)
              path = {
                'lua/?.lua',
                'lua/?/init.lua',
              },
            },
            workspace = {
              checkThirdParty = false,
              library = { vim.env.VIMRUNTIME },
            },
          }
        )
      end,
      settings = { Lua = {}, },
    })
    vim.lsp.enable 'lua_ls'
  '';
}
