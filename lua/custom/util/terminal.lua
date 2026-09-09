local lg_buf -- lazygit terminal buffer; nil = not started yet

local M = {}

function M.lazygit()
  local alive = lg_buf and vim.api.nvim_buf_is_valid(lg_buf)
    and vim.fn.jobwait({ vim.b[lg_buf].terminal_job_id }, 0)[1] == -1

  -- already shown here and alive? toggle back to the alternate buffer
  if alive and vim.api.nvim_win_get_buf(0) == lg_buf then
    local alt = vim.fn.bufnr '#'
    if alt ~= -1 and alt ~= lg_buf then vim.api.nvim_win_set_buf(0, alt) end
    return
  end

  if not alive then
    lg_buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_call(lg_buf, function() vim.fn.jobstart({ 'lazygit' }, { term = true }) end)
  end

  vim.api.nvim_win_set_buf(0, lg_buf)
  vim.cmd 'startinsert'
end

return M
