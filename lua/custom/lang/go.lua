---@class Custom.Lang.Module
local M = {
  parsers = { 'go', 'gomod', 'gowork', 'gosum' },
  tools = { 'goimports', 'gofumpt', 'gomodifytags', 'impl', 'golangci-lint' },
  formatters_by_ft = { go = { 'goimports', 'gofumpt' } },
  linters_by_ft = { go = { 'golangcilint' } },
}

vim.lsp.config('gopls', {
  settings = {
    gopls = {
      gofumpt = true,
      completeUnimported = true,
      usePlaceholders = true,
      staticcheck = true,
    },
  },
})

vim.lsp.enable 'gopls'

return M
