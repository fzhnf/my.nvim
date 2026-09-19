local vp = require 'custom.util.vimpack_helper'
local lang = require 'custom.lang'

-- Filetypes to autoformat on save. `typst` is here because it is formatted by
-- its LSP server through `lsp_format = 'fallback'` rather than by a CLI formatter.
local enabled_filetypes = {
  lua = true,
  python = true,
  php = true,
  typst = true,
}
for ft in pairs(lang.formatters_by_ft) do
  enabled_filetypes[ft] = true
end

local function setup()
  vim.pack.add { vp.gh 'stevearc/conform.nvim' }
  require('conform').setup {
    notify_on_error = false,
    format_on_save = function(bufnr)
      if enabled_filetypes[vim.bo[bufnr].filetype] then return { timeout_ms = 500 } end
    end,
    default_format_opts = {
      lsp_format = 'fallback', -- Use external formatters if configured, otherwise use LSP formatting. Set to `false` to disable LSP formatting entirely.
    },
    -- Formatters are declared per filetype in lua/custom/lang/*.lua
    formatters_by_ft = lang.formatters_by_ft,
  }
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = vim.tbl_keys(enabled_filetypes),
  once = true,
  callback = setup,
})

vim.keymap.set({ 'n', 'v' }, '<leader>cf', function()
  if not package.loaded['conform'] then setup() end
  require('conform').format { async = true }
end, { desc = '[C]ode [F]ormat' })
