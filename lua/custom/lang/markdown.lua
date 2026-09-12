local vp = require 'custom.util.vimpack_helper'
local lang = require 'custom.util.lang'

lang.add_parser { 'markdown', 'markdown_inline' }
lang.add_tool 'markdownlint-cli2'
local lint = require 'lint'
lint.linters_by_ft['markdown'] = { 'markdownlint-cli2' }
lint.linters['markdownlint-cli2'].args = { '--config', vim.fn.stdpath 'config' .. '/.markdownlint-cli2.yaml', '--' }

vim.pack.add({ { src = vp.gh 'iamcco/markdown-preview.nvim' } }, {
  load = function(plug_data)
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'markdown',
      once = true,
      callback = function() vim.cmd.packadd(plug_data.spec.name) end,
    })
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function(args)
    vim.keymap.set('n', '<leader>cp', '<cmd>MarkdownPreview<cr>', {
      buffer = args.buf,
      desc = 'Markdown Preview',
    })
  end,
})
