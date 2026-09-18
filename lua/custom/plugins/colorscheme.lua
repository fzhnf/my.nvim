-- You can easily change to a different colorscheme.
-- Change the name of the colorscheme plugin below, and then
-- change the command under that to load whatever the name of that colorscheme is.
--
-- vim.pack.add { vp.gh 'folke/tokyonight.nvim' }
vim.pack.add {
  {
    src = 'https://github.com/rose-pine/neovim',
    name = 'rose-pine',
  },
}

---@diagnostic disable-next-line: missing-fields
require('rose-pine').setup {}

-- Load the colorscheme here.
-- Like many other themes, this one has different styles, and you could load
-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
vim.cmd.colorscheme 'rose-pine'
