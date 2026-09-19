local vp = require 'custom.util.vimpack_helper'

---@class Custom.Lang.Module
local M = {
  parsers = { 'typst' },
  tools = { 'tinymist' },
}

vim.lsp.config('tinymist', { settings = { formatterMode = 'typstyle' } })
vim.lsp.enable 'tinymist'

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'typst',
  once = true,
  callback = function()
    vim.pack.add { vp.gh 'chomosuke/typst-preview.nvim' }
    require('typst-preview').setup { dependencies_bin = { tinymist = 'tinymist' } }
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'typst',
  callback = function(args)
    vim.keymap.set('n', '<leader>cp', '<cmd>TypstPreviewToggle<cr>', { buffer = args.buf, desc = 'Toggle Typst Preview' })
    vim.keymap.set('n', '<leader>cP', '<cmd>LspTinymistPinMain<cr>', { buffer = args.buf, desc = 'Tinymist: Pin main file' })
  end,
})

return M
