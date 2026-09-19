local vp = require 'custom.util.vimpack_helper'

-- ============================================================
-- SESSION MANAGEMENT
-- persistence.nvim
-- ============================================================
vim.pack.add { vp.gh 'olimorris/persisted.nvim' }
require('persisted').setup {
  before_save = function()
    if package.loaded['fyler'] then require('fyler').close() end
  end,
}

vim.keymap.set('n', '<leader>qs', function() require('persisted').load() end, { desc = 'Restore Session' })
vim.keymap.set('n', '<leader>qS', function() require('persisted').select() end, { desc = 'Select Session' })
vim.keymap.set('n', '<leader>ql', function() require('persisted').load { last = true } end, { desc = 'Restore Last Session' })
vim.keymap.set('n', '<leader>qd', function() require('persisted').stop() end, { desc = "Don't Save Current Session" })
