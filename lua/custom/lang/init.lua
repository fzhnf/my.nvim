-- Loads every language file in this directory and returns the aggregated
-- `{ parsers = {...}, tools = {...} }` declared by each file's `return`.
--
-- Usage: local lang = require 'custom.lang'  ->  lang.parsers, lang.tools
-- `vim.fs.dir()` iteration order is unspecified, so language files must not rely on it.
--
---@class Custom.Lang.Module
---@field parsers string[]
---@field tools string[]

---@type Custom.Lang.Module
local M = { parsers = {}, tools = {} }

local plugins_dir = vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', 'custom', 'lang')
for file_name, kind in vim.fs.dir(plugins_dir, { follow = true }) do
  if (kind == 'file' or kind == 'link') and file_name:match '%.lua$' and file_name ~= 'init.lua' then
    local mod = require('custom.lang.' .. file_name:gsub('%.lua$', ''))
    if type(mod) == 'table' then
      vim.list_extend(M.parsers, mod.parsers or {})
      vim.list_extend(M.tools, mod.tools or {})
    end
  end
end

return M
