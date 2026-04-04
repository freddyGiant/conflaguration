{ pkgs, ... }: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    { plugin = gruvbox-material-nvim;
      type = "lua";
      config = /* lua */ "require('gruvbox-material').setup()";
    }

    vim-repeat

    { plugin = blink-cmp;
      type = "lua";
      config = /* lua */ ''
        require('blink.cmp').setup {
          completion = {
            documentation = {
              auto_show = true,
              auto_show_delay_ms = 80,
            },
            list = {
              selection = {
                preselect = false,
                auto_insert = true,
              },
            },
            trigger = {
              show_on_backspace = true,
              show_on_backspace_in_keyword = true,
              show_on_insert = true,
            },
          },

          keymap = {
            preset = 'enter',

            ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
            ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
          },

          cmdline = {
            keymap = { preset = 'inherit' },
            completion = {
              menu = { auto_show = true, },
              list = {
                selection = {
                  preselect = false,
                  auto_insert = true,
                },
              },
            },
          },

          signature = { enabled = true, },
        }
      '';
    }

    { plugin = leap-nvim;
      type = "lua";
      # see https://codeberg.org/andyg/leap.nvim
      config = /* lua */ ''
        -- LEAP-NVIM
        vim.keymap.set({'n', 'x', 'o'}, 's', '<Plug>(leap)')
        vim.keymap.set('n',             'S', '<Plug>(leap-from-window)')

        require('leap').opts.preview = function (ch0, ch1, ch2)
          return not (
            ch1:match('%s')
            or (ch0:match('%a') and ch1:match('%a') and ch2:match('%a'))
          )
        end

        require('leap').opts.equivalence_classes = {
          ' \t\r\n', '([{', ')]}', '\'"`'
        }

        -- wut
        require('leap.user').set_repeat_keys('<enter>', '<bs>')
      '';
    }
  ];
}
