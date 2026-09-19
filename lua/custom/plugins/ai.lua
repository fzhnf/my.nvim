local vp = require 'custom.util.vimpack_helper'

vim.api.nvim_create_autocmd('InsertEnter', {
  once = true,
  callback = function()
    vim.pack.add {
      vp.gh 'zbirenbaum/copilot.lua',
      vp.gh 'giuxtaposition/blink-cmp-copilot',
    }

    require('copilot').setup {
      suggestion = { enabled = false },
      panel = { enabled = false },
    }
  end,
})
