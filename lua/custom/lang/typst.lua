local lang = require 'custom.util.lang'
lang.add_parser 'typst'
lang.add_tool 'tinymist'
vim.lsp.enable 'tinymist'
