-- You can add your own language's plugins & configs here or in other files in this directory!
-- I promise not to create any merge conflicts in this directory :)

---@class Custom.Lang.Module
---@field parsers string[]
---@field tools string[]
---@field formatters_by_ft table<string, string[]>?
---@field linters_by_ft table<string, string[]>?

---@type Custom.Lang.Module
local M = {
  -- install default parser
  parsers = { 'bash', 'c', 'css', 'diff', 'html', 'javascript', 'luadoc', 'query', 'vim', 'vimdoc' },
  tools = {},
  formatters_by_ft = {},
  linters_by_ft = {},
}

-- Iterate over all Lua files in the lang directory and load them.
-- `vim.fs.dir()` iteration order is unspecified and must not be relied upon.
local lang_dir = vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', 'custom', 'lang')
for file_name, kind in vim.fs.dir(lang_dir, { follow = true }) do
  if (kind == 'file' or kind == 'link') and file_name:match '%.lua$' and file_name ~= 'init.lua' then
    local module = file_name:gsub('%.lua$', '')

    -- return the aggregated parsers, tools & formatters/linters for treesitter, mason, conform & nvim-lint
    local lang = require('custom.lang.' .. module)
    if type(lang) == 'table' then
      vim.list_extend(M.parsers, lang.parsers or {})
      vim.list_extend(M.tools, lang.tools or {})
      M.formatters_by_ft = vim.tbl_deep_extend('force', M.formatters_by_ft, lang.formatters_by_ft or {})
      M.linters_by_ft = vim.tbl_deep_extend('force', M.linters_by_ft, lang.linters_by_ft or {})
    end
  end
end

return M
