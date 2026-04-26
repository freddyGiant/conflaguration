vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- vim.o.smoothscroll = true
vim.o.virtualedit = 'block'

-- BASIC EDITOR BEHAVIOR
-- simple options affecting the buttons i press
do
  -- AMBIGIUOUS KEY SEQUENCE TIMEOUT
  vim.o.ttimeoutlen = 5
  -- we want to avoid these anyway

  -- INDENTATION
  vim.o.shiftwidth  = 2
  vim.o.tabstop     = 2
  vim.o.softtabstop = 2
  vim.o.expandtab   = true
  vim.o.shiftround  = true
  -- vim.o.autoindent  = true

  -- vim.keymap.set('n', [[<A-[>]], function()
  --   local n = vim.v.count or 1
  --   return '<CMD>' .. string.rep('<', vim.v.count1) .. '<CR>'
  -- end, { expr = true })
  -- vim.keymap.set('n', [[<A-]>]], function()
  --   return '<CMD>' .. string.rep('>', vim.v.count1) .. '<CR>'
  -- end, { expr = true })

  vim.keymap.set('n', [[<A-[>]], function (_)
    vim.cmd(string.rep('<', vim.v.count1))
  end)
  vim.keymap.set('n', [[<A-]>]], function (_)
    vim.cmd(string.rep('>', vim.v.count1))
  end)
  vim.keymap.set('i', [[<A-[>]], [[<C-d>]])
  vim.keymap.set('i', [[<A-]>]], [[<C-t>]])
  vim.keymap.set('v', [[<A-[>]], [[<gv]])
  vim.keymap.set('v', [[<A-]>]], [[>gv]])

  -- SEARCH
  vim.o.ignorecase = true;
  vim.o.smartcase = true;
  -- NOTE: CTRL-L does this by default!!!
  -- vim.keymap.set('n', [[<ESC>]], [[<CMD>nohlsearch<CR>]])
  vim.keymap.set('n', [[n]],     [[nzzzv]])
  vim.keymap.set('n', [[N]],     [[Nzzzv]])

  -- FOLDS
  vim.o.foldlevel = 99
  -- vim.o.foldlevel = 2
  -- vim.o.foldlevelstart = 2
  -- vim.opt.foldopen:remove { 'block', 'jump' }

  -- all but block (to allow jumping around folded paragraphs)
  vim.opt.foldopen = {
    'hor',
    'insert',
    'jump',
    'mark',
    'percent',
    'quickfix',
    'search',
    'tag',
    'undo',
  }

  vim.keymap.set('n', [[<A-c>]], [[zc]])
  vim.keymap.set('n', [[<A-C>]], [[zC]])
  vim.keymap.set('n', [[<A-o>]], [[zo]])
  vim.keymap.set('n', [[<A-O>]], [[zO]])
  -- vim.keymap.set('n', '<A-j>', 'zj')
  -- vim.keymap.set('n', '<A-k>', 'zk')
  -- vim.keymap.set('n', '<A-v>', 'zv')

  -- UNDO
  vim.o.undofile = true

  -- WINDOWS
  vim.o.splitright = true
  vim.o.splitbelow = true
  vim.o.equalalways = false
  vim.keymap.set('n', [[<A-h>]], [[<C-w>h]])
  vim.keymap.set('n', [[<A-j>]], [[<C-w>j]])
  vim.keymap.set('n', [[<A-k>]], [[<C-w>k]])
  vim.keymap.set('n', [[<A-l>]], [[<C-w>l]])
  vim.keymap.set('n', [[<A-q>]], [[<C-w>q]])
  vim.keymap.set('n', [[<A-w>]], [[<C-w>w]])

  -- SCROLLING
  vim.o.scrolloff = 4
  -- CENTER CURSOR ON MOVE

  vim.api.nvim_create_autocmd(
    { 'BufEnter', 'CursorMoved', 'CursorMovedI', }, {
      callback = function()
        local prev = vim.b.center_cursor_previous_line
        local pos = vim.api.nvim_win_get_cursor(0)
        local line, _ = unpack(pos)
        -- we always want to update this
        vim.b.center_cursor_previous_line = line

        if vim.b.center_cursor_enabled == nil then
          vim.b.center_cursor_enabled = true
        end

        if not vim.b.center_cursor_enabled then return end

        if prev ~= nil and line ~= prev then
          -- TODO: consider preventing too many lines at EOF
          -- https://vi.stackexchange.com/questions/26019/how-can-i-make-zz-not-center-cursor-when-approaching-end-of-file
          vim.cmd.norm { 'zz', bang = true, }
          vim.api.nvim_win_set_cursor(0, pos)
        end
      end,
      group = vim.api.nvim_create_augroup('vrad.center_cursor', {}),
    }
  )

  ---Don't center the cursor as a result of this keymap
  ---@param mode string | string[]
  ---@param lhs string
  local function map_no_center_cursor(mode, lhs)
    vim.keymap.set(mode, lhs, function()
      local old = vim.b.center_cursor_enabled
      vim.b.center_cursor_enabled = false

      local keys = vim.api.nvim_replace_termcodes(lhs, true, false, true)
      vim.api.nvim_feedkeys(keys, 'n', false)

      vim.schedule(function() vim.b.center_cursor_enabled = old end)
    end)
  end

  map_no_center_cursor('n', [[H]])
  map_no_center_cursor('n', [[L]])
  map_no_center_cursor('n', [[<C-e>]])
  map_no_center_cursor('n', [[<C-y>]])
  -- map_no_center_cursor('n', [[<C-f>]])
  -- map_no_center_cursor('n', [[<C-b>]])

  -- MOUSE
  -- disable drag to select, so drag only resizes windows
  vim.o.mouse = 'n'
  -- focus follows mouse
  -- FIXME: does this even work? footterm support?
  vim.o.mousefocus = true

  -- leave terminal mode (and go into fish terminal mode)
  -- NOTE: may have issues with nested neovim
  vim.keymap.set('t', [[<ESC><ESC>]], [[<ESC><C-\><C-n>]])

  -- split line and trim whitespace at (before) cursor
  -- NOTE: the `e` flag for `:s` doesn't go to the end of the search, it
  -- suppresses errors
  -- (in general, the flags are different for / and s/)
  vim.keymap.set('i', [[<C-j>]],  [[<CR><ESC>m`<CMD>.-1s/\v\s+$//e<CR><ESC>``i]])
  vim.keymap.set('n', [[<C-j>]], [[i<CR><ESC>m`<CMD>.-1s/\v\s+$//e<CR><ESC>``]])
  vim.keymap.set('v', [[<C-j>]], [[c<CR><ESC>m`<CMD>.-1s/\v\s+$//e<CR><ESC>``]])
end

-- COMPLETION
do
  vim.opt.completeopt = { 'fuzzy', 'menuone', 'noselect', 'popup', 'preview', }
end

-- VISUAL TWEAKS
do
  vim.o.termguicolors = true
  vim.o.showmode = false
  vim.o.shortmess = 'aTWAIc'
  vim.o.winborder = 'none'

  -- "TRANSPARENT" FOLDTEXT
  vim.o.foldtext = ''

  -- WRAPPING
  -- TODO: you know what, you freak.
  vim.o.linebreak = true
  -- indent wrapped lines
  vim.o.breakindent = true
  -- by 1 beyond the first line
  vim.o.breakindentopt = 'shift:1'
  -- why isn't this working
  -- vim.opt.breakindentopt:append { shift = '1' }

  -- LINES & NUMBERING
  do
    vim.o.number = true

    local group = vim.api.nvim_create_augroup("vrad.numberline", {})

    -- hybrid numbers, cursorline when focused & in normal mode
    vim.api.nvim_create_autocmd(
      {
        "BufEnter", "WinEnter", "FocusGained",
        "InsertLeave", "CmdlineLeave", "TermLeave",
      },
      {
        callback = function ()
          if vim.wo.number then
            vim.wo.relativenumber = true
            vim.wo.cursorline = true
          end
        end,
        group = group,
      }
    )

    -- absolute numbers, no cursorline otherwise
    vim.api.nvim_create_autocmd(
      {
        "InsertEnter", "CmdlineEnter", "TermEnter",
        "BufLeave", "WinLeave", "FocusLost",
      },
      {
        callback = function()
          if vim.wo.number then
            vim.wo.relativenumber = false
            vim.wo.cursorline = false
          end
        end,
        group = group,
      }
    )
  end

  -- WHITESPACE VISUALIZATION
  vim.o.list = true
  -- TODO: options for nowrap
  vim.opt.listchars = {
    -- eol = '¬',
    extends = '▸',
    precedes = '◂',

    -- i tend to miss this dot anyway
    -- space = '·',
    nbsp = '␣',
    trail = '·',
    leadmultispace = '│ ',
    multispace = '···+',

    tab = '| ',
  }

  -- INDENT SCOPE VERTICAL LINES
  vim.api.nvim_create_autocmd('OptionSet', {
    -- use softtabstop since this is space-specific
    pattern = 'softtabstop',
    callback = function()
      local ms = '│' .. string.rep(' ', vim.v.option_new - 1)
      vim.print(ms)
      if vim.v.option_type == "global" then
        vim.opt.listchars:append { leadmultispace = ms }
      else
        vim.opt_local.listchars:append { leadmultispace = ms }
      end
    end,
    group = vim.api.nvim_create_augroup('vrad.list_indent', {}),
  })

  -- DIAGNOSTICS
  vim.diagnostic.config {
    severity_sort = true,
    float = { border = 'single', source = 'if_many', },
    -- underline = { severity = vim.diagnostic.severity.ERROR },
    signs = vim.g.have_nerd_font and {
      text = {
        [vim.diagnostic.severity.ERROR] = '󰅚 ',
        [vim.diagnostic.severity.WARN] = '󰀪 ',
        [vim.diagnostic.severity.INFO] = '󰋽 ',
        [vim.diagnostic.severity.HINT] = '󰌶 ',
      },
    } or {},

    virtual_text = {
      source = 'if_many',
      spacing = 1,
      prefix = '',
      virt_text_pos = 'eol_right_align',
      -- this probably isn't even necessary since we're not actually casing on
      -- anything
      format = function(diagnostic)
        -- i'm honestly not sure what's going on here
        -- vim.print(diagnostic)
        local diagnostic_message = {
          [vim.diagnostic.severity.ERROR] = diagnostic.message,
          [vim.diagnostic.severity.WARN] = diagnostic.message,
          [vim.diagnostic.severity.INFO] = diagnostic.message,
          [vim.diagnostic.severity.HINT] = diagnostic.message,
        }
        return diagnostic_message[diagnostic.severity]
      end,
    },
  }

  vim.keymap.set('n', [[<LEADER>q]], vim.diagnostic.setloclist)
  vim.keymap.set('n', [[<LEADER>e]], vim.diagnostic.open_float)
  vim.keymap.set('n', [[]q]], function() vim.diagnostic.jump { count = 1, } end)
  vim.keymap.set('n', [[[q]], function() vim.diagnostic.jump { count = -1, } end)
end

-- BUFFER MANAGEMENT
do
  vim.o.autoread = true

  -- DELETE BUFFER BUT PRESERVE WINDOW LAYOUT WITH [NO NAME] BUFFER
  vim.api.nvim_create_user_command(
    'Bd',
    'new | bd #',
    { desc = 'Replace the current window with [No Name] rather than closing it on bd', }
  )

  -- PREVENT "EDITING READ-ONLY FILE" WARNING FROM GETTING IN THE WAY
  -- (see :help W10)
  vim.api.nvim_create_autocmd(
    'FileChangedRO',
    {
      callback = function()
        vim.api.nvim_echo(
          { {'W10: Warning: Changing a readonly file', 'WarningMsg'} },
          true,
          {}
        )
        vim.bo.readonly = false
      end,
      desc = 'Suppress W10; echo instead',
      group = vim.api.nvim_create_augroup('vrad.ro_warning', {}),
    }
  )

  -- WRITE READ-ONLY FILES
  vim.api.nvim_create_user_command('W', function()
    -- I feel a lot safer doing this than using lua utils sudo_write, for example
    -- For some reason, doing the command all-in-one with a pipe leaves the buffer 'modified'
    -- FIXME: is this idiomatic?
    vim.cmd('silent! w !sudo tee % > /dev/null')
    vim.cmd('e!')
    -- TODO: restore folds? or find other solution
  end, { desc = 'Silently use \'write with sudo tee\' trick', })
end

-- NETRW
do
  vim.g.netrw_banner = 0
  vim.g.netrw_preview = 1
  vim.g.netrw_liststyle = 3
  vim.g.netrw_winsize = 30
  vim.g.netrw_silent = 1
end

-- POP-UP TERMINAL
vim.keymap.set('n', [[<LEADER>t]], function()
  vim.cmd('botright 10split')

  ---@type boolean, string?
  local succeeded, err = pcall(function() vim.cmd.buffer 'term' end)

  if not succeeded then
    assert(err ~= nil)
    if string.find(err, 'Vim:E93') or string.find(err, "Vim:E94") then
      vim.cmd.term()
    else
      error(err)
    end
  end

  vim.cmd.startinsert()
end)

-- RE-SOURCE CURRENT CONFIG
vim.api.nvim_create_user_command(
  'ReCfg',
  function(cmd)
    local cfg_path = os.getenv('MYVIMRC')

    for i, arg in ipairs(vim.v.argv) do
      -- command line arg to use an alternate config
      if arg == '-u' then
        cfg_path = vim.v.argv[i + 1]
        break
      end
    end

    if not cfg_path then
      print(cmd.name .. ': Can\'t identify config in use')
      return
    end

    local ok, err = pcall(vim.cmd.source, cfg_path)
    if ok then
      print(cmd.name .. ': Sourced ' .. cfg_path)
    else
      -- getting a little long, are we?
      print(cmd.name .. ': Failed to source ' .. cfg_path .. '; ' .. err)
    end
  end,
  {
    desc = 'Re-source in-use Neovim configuration',
    nargs = 0,
  }
)

-- vim: fdl=0
