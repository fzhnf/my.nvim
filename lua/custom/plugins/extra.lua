local vp = require 'custom.util.vimpack_helper'
vim.pack.add { vp.gh 'vyfor/cord.nvim' }
require('cord').setup {
  display = { theme = 'minecraft', flavor = 'accent' },
  buttons = {
    {
      label = 'View Repository',
      url = function(opts) return opts.repo_url end,
    },
  },
}
