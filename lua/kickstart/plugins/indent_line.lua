local vp = require 'custom.util.vimpack'

-- Add indentation guides even on blank lines

-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help ibl`
vim.pack.add { vp.gh 'lukas-reineke/indent-blankline.nvim' }
require('ibl').setup {}
