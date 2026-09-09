local vp = require 'custom.util.vimpack'

vim.pack.add { vp.gh 'zbirenbaum/copilot.lua' }
require('copilot').setup {
  suggestion = { enabled = false },
  panel = { enabled = false },
}
vim.pack.add { vp.gh 'giuxtaposition/blink-cmp-copilot' }
