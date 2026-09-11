local M = { parsers = {}, tools = {} }

---@param parser string
function M.add_parser(parser) M.parsers[#M.parsers + 1] = parser end

---@param tool string
function M.add_tool(tool) M.tools[#M.tools + 1] = tool end

return M
