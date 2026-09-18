---@class Custom.Lang.Module
local M = {
  parsers = { 'rust' },
  tools = { 'rust_analyzer' },
}

-- Some languages (like rust) have entire language plugins that can be useful:
--    https://github.com/mrcjkb/rustaceanvim
--
-- But for many setups, the LSP (`rust_analyzer`) will work just fine
vim.lsp.enable 'rust_analyzer'

return M
