---@class Custom.Lang.Module
local M = {
  parsers = { 'php', 'php_only', 'blade' },
  tools = { 'phpactor' },
  formatters_by_ft = { php = { 'pint' } },
  linters_by_ft = { php = { 'phpstan' } },
}

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

return M
