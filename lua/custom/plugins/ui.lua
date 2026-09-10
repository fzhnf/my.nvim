local vp = require 'custom.util.vimpack_helper'

require('mini.tabline').setup {
  -- Whether to show file icons (requires 'mini.icons')
  show_icons = true,

  -- Function which formats the tab label
  -- By default surrounds with space and possibly prepends with icon
  -- format = nil,

  -- Where to show tabpage section in case of multiple vim tabpages.
  -- One of 'left', 'right', 'none'.
  tabpage_section = 'left',
}
vim.keymap.set('n', '<S-h>', '<Cmd>bprevious<CR>', { desc = 'Prev Buffer' })
vim.keymap.set('n', '<S-l>', '<Cmd>bnext<CR>', { desc = 'Next Buffer' })

vim.pack.add { vp.gh 'rachartier/tiny-cmdline.nvim' }
require('vim._core.ui2').enable {}
vim.o.cmdheight = 0

-- Useful status updates for LSP.
vim.pack.add { vp.gh 'j-hui/fidget.nvim' }
require('fidget').setup {}

vim.pack.add { vp.gh 'nvimdev/dashboard-nvim' }
require('dashboard').setup {
  theme = 'doom',
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'dashboard' },
  callback = function(ev)
    -- fillchars is window-local; grab this buffer's window
    local win = vim.iter(vim.api.nvim_list_wins()):find(function(w) return vim.api.nvim_win_get_buf(w) == ev.buf end)
    if win then vim.wo[win].fillchars = 'eob: ' end
  end,
})
