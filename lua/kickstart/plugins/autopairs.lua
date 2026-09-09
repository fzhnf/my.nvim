local vp = require 'custom.util.vimpack'

-- autopairs
-- https://github.com/windwp/nvim-autopairs

vim.pack.add { vp.gh 'windwp/nvim-autopairs' }
require('nvim-autopairs').setup {}
