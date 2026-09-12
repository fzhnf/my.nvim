local lang = require 'custom.util.lang'

lang.add_parser 'python'
lang.add_tool { 'pyright', 'ruff' }

require('lint').linters_by_ft['python'] = { 'ruff' }
require('conform').formatters_by_ft.python = { 'ruff_organize_imports', 'ruff_format' }

vim.lsp.config('ruff', {
  cmd_env = { RUFF_TRACE = 'messages' },
  init_options = { settings = { logLevel = 'error' } },
})

vim.lsp.enable { 'ruff', 'pyright' }

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lang-python-lsp', { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == 'ruff' then client.server_capabilities.hoverProvider = false end
  end,
})
