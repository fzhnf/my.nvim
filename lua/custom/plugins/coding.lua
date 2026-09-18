vim.pack.add { 'https://github.com/nvim-mini/mini.pairs' }
require('mini.pairs').setup {}

vim.pack.add { 'https://github.com/nvim-mini/mini.ai' }
require('mini.ai').setup {
  -- NOTE: Avoid conflicts with the built-in incremental selection mappings on Neovim>=0.12 (see `:help treesitter-incremental-selection`)
  mappings = {
    around_next = 'aa',
    inside_next = 'ii',
  },
  n_lines = 500,
}
