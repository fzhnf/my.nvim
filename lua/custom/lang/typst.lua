local vp = require 'custom.util.vimpack_helper'
local lang = require 'custom.util.lang'

lang.add_parser 'typst'
lang.add_tool 'tinymist'
vim.lsp.enable 'tinymist'

vim.pack.add({
  {
    src = vp.gh 'chomosuke/typst-preview.nvim',
    data = {
      opts = {
        dependencies_bin = {
          tinymist = 'tinymist',
        },
      },
    },
  },
}, {
  load = function(plug_data)
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'typst',
      once = true,
      callback = function()
        vim.cmd.packadd(plug_data.spec.name)
        require('typst-preview').setup(plug_data.spec.data.opts)
      end,
    })
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'typst',
  callback = function(args)
    vim.keymap.set('n', '<leader>cp', '<cmd>TypstPreviewToggle<cr>', {
      buffer = args.buf,
      desc = 'Toggle Typst Preview',
    })
  end,
})
