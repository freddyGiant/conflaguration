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
