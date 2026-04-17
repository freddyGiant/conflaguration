{ pkgs, ... }: let
  # [`nixpkgs.vimPlugins.nvim-treesitter.withPlugins`](https://github.com/NixOS/nixpkgs/blob/6295c384cf8034c5481ed1913063c59fc69756cd/pkgs/applications/editors/vim/plugins/nvim-treesitter/generated.nix)
  # will fetch the grammars packaged in
  # [`nixpkgs.vimPlugins.nvim-treesitter-parsers.*`](https://github.com/NixOS/nixpkgs/blob/6295c384cf8034c5481ed1913063c59fc69756cd/pkgs/applications/editors/vim/plugins/nvim-treesitter/generated.nix),
  # where `*` is each of the languages listed in the argument to this option.
  #
  # Note that this is just the set of treesitter grammars that are supported by
  # nixpkgs *as Vim plugins*. There are plenty more grammars in nixpkgs (and
  # elsewhere) that can be trivially packaged into Vim plugins with
  # `nixpkgs.lib` functions.
  grammars = [
    "bash"
    "c"
    "css"
    "fish"
    "html"
    "latex"
    "lua"
    "markdown"
    "markdown-inline"
    "nix"
    "python"
    "qmljs"
    "regex"
    /* experimental, for SML */ "ocaml"
  ];
  tsWithGrammars = pkgs.vimPlugins.nvim-treesitter.withPlugins (p:
    map (g: p.g) grammars
  );
in {
  programs.neovim.plugins = [
    {
      plugin = tsWithGrammars;
      type = "lua";
      config = /* lua */ ''
        -- NVIM-TREESITTER
        require('nvim-treesitter.configs').setup {
          auto_install = false, -- managed by Nix

          highlight = { enable = true, },
          indent = { enable = true },

          incremental_selection = {
            enable = true,
            keymaps = {
              init_selection = '<C-space>',
              node_incremental = '<C-space>',
              scope_incremental = false,
              node_decremental = '<bs>',
            },
          },

          textobjects = {
            select = {
              enable = true,
              lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
              keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['aa'] = '@parameter.outer',
                ['ia'] = '@parameter.inner',
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
              },
            },

            move = {
              enable = true,
              set_jumps = true, -- whether to set jumps in the jumplist
              goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer',
              },
              goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer',
              },
              goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer',
              },
              goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer',
              },
            },

            swap = {
              enable = true,
              swap_next = {
                ['<leader>a'] = '@parameter.inner',
              },
              swap_previous = {
                ['<leader>A'] = '@parameter.inner',
              },
            },
          },
        }

        vim.o.foldmethod = 'expr'
        vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      '';
    }
  ];

  home.packages = with pkgs; [
    curl
    stdenv.cc
  ];
}
