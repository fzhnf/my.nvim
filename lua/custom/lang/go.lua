---@class Custom.Lang.Module
local M = {
  parsers = { 'go', 'gomod', 'gowork', 'gosum' },
  tools = { 'goimports', 'gofumpt', 'gomodifytags', 'impl', 'golangci-lint', 'delve' },
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

require('lint').linters_by_ft['go'] = { 'golangcilint' }
require('conform').formatters_by_ft['go'] = { 'goimports', 'gofumpt' }

return M
