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

  -- -- use completion if available
  -- if client:supports_method('textDocument/completion') then
  --   vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true, })
  -- end

  -- horseshit?
  -- if client:supports_method('textDocument/definition') then
  vim.keymap.set('n', [[gd]], vim.lsp.buf.definition, { buffer = event.buf, })
  -- end
  vim.keymap.set('n', [[gD]], vim.lsp.buf.declaration, { buffer = event.buf, })
  vim.keymap.set('n', [[<leader>d]], vim.lsp.buf.type_definition, { buffer = event.buf, })
end)

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

on_attach('basedpyright', function(event, client)
  vim.api.nvim_buf_create_user_command(
    event.buf,
    'LspPyrightUsePoetry',
    function(cmd)
      local succeeded, result = pcall(vim.system,
        { 'poetry', 'env', 'info', '-e', },
        {
          cwd = client.workspace_folders[1].name,
          text = true,
        },
        vim.schedule_wrap(function(result)
          if result.code ~= 0 then
            vim.print(
              cmd.name .. ': ' ..
              table.concat(result.cmd, ' ') .. ': ' ..
              result.stderr
            )
            return
          end

          local env_path = vim.fn.trim(result.stdout)
          vim.print(cmd.name .. ': python path set to ' .. env_path)
          vim.cmd.LspPyrightSetPythonPath(env_path)
        end)
      )

      if not succeeded then
        vim.print(cmd.name .. ': ' .. result)
      end
    end,
    {}
  )

  vim.cmd.LspPyrightUsePoetry { mods = { emsg_silent = true } }
end)
vim.lsp.enable 'basedpyright'

vim.lsp.config('nil', {})
vim.lsp.enable 'nil'

vim.lsp.enable 'clangd'
