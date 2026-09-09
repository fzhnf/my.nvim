local vp = require 'custom.util.vimpack'
vim.pack.add { vp.gh 'nvim-mini/mini.tabline' }
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
