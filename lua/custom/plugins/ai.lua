local vp = require 'custom.util.vimpack_helper'

vim.pack.add({
  src = vp.gh 'zbirenbaum/copilot.lua',
  data = { opts = { suggestion = { enabled = false }, panel = { enabled = false } } },
}, {
  load = function(plug_data)
    vim.api.nvim_create_autocmd('InsertEnter', {
      once = true,
      callback = function()
        vim.cmd.packadd(plug_data.spec.name)
        require('copilot').setup(plug_data.spec.data.opts)
      end,
    })
  end,
})

vim.pack.add({ vp.gh 'giuxtaposition/blink-cmp-copilot' }, {
  load = function(plug_data)
    vim.api.nvim_create_autocmd('InsertEnter', {
      once = true,
      callback = function() vim.cmd.packadd(plug_data.spec.name) end,
    })
  end,
})
