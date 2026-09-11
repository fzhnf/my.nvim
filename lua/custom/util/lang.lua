local M = { parsers = {}, tools = {} }

---@param parser string|string[]
function M.add_parser(parser)
  if type(parser) == 'table' then return vim.list_extend(M.parsers, parser) end
  M.parsers[#M.parsers + 1] = parser
end

---@param tool string|string[]
function M.add_tool(tool)
  if type(tool) == 'table' then return vim.list_extend(M.tools, tool) end
  M.tools[#M.tools + 1] = tool
end

return M
