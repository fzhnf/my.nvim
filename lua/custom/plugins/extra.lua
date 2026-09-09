vim.pack.add { 'https://github.com/vyfor/cord.nvim' }
require('cord').setup {
  display = { theme = 'minecraft', flavor = 'accent' },
  buttons = {
    {
      label = 'View Repository',
      url = function(opts) return opts.repo_url end,
    },
  },
}
