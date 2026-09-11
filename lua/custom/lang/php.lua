local lang = require 'custom.util.lang'
lang.add_parser { 'php', 'php_only', 'blade' }
lang.add_tool 'phpactor'

require('lint').linters_by_ft['php'] = { 'phpstan' }
require('conform').formatters_by_ft.php = { 'pint' }

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
