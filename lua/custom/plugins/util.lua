local vp = require 'custom.util.vimpack_helper'

-- [[ session manager ]]
vim.pack.add { vp.gh 'olimorris/persisted.nvim' }
require('persisted').setup {
  before_save = function() require('fyler').close() end,
}
