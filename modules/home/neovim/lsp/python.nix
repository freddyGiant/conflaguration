{ config, lib, pkgs, ... }: {
  home.packages = [ pkgs.basedpyright ];
  programs.neovim.extraLuaConfig = config.lib.neovim.order.mkLsp /* lua */ ''
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
  '';
}
