local lang = require 'custom.util.lang'
lang.add_parser 'php'
lang.add_parser 'php_only'
lang.add_parser 'blade'
lang.add_tool 'phpactor'

vim.lsp.config('laravel_lsp', {
  cmd = { 'laravel-lsp' },
  filetypes = { 'php', 'blade' },
  root_dir = function(bufnr, on_dir)
    local root = vim.fs.root(bufnr, 'artisan')
    if root then on_dir(root) end
  end,
})

vim.lsp.enable 'phpactor'
vim.lsp.enable 'laravel_lsp'
