local vp = require 'custom.util.vimpack_helper'

require('mini.tabline').setup {
  -- Whether to show file icons (requires 'mini.icons')
  show_icons = true,

  -- Function which formats the tab label
  -- By default surrounds with space and possibly prepends with icon
  -- format = nil,

  -- Where to show tabpage section in case of multiple vim tabpages.
  -- One of 'left', 'right', 'none'.
  tabpage_section = 'left',
}
vim.keymap.set('n', '<S-h>', '<Cmd>bprevious<CR>', { desc = 'Prev Buffer' })
vim.keymap.set('n', '<S-l>', '<Cmd>bnext<CR>', { desc = 'Next Buffer' })

vim.pack.add { vp.gh 'rachartier/tiny-cmdline.nvim' }
require('vim._core.ui2').enable {}
vim.o.cmdheight = 0

-- Useful status updates for LSP.
vim.pack.add { vp.gh 'j-hui/fidget.nvim' }
require('fidget').setup {}

-- put persisted before dashboard-nvim, one row in dashboard-nvim depends on
-- persisted's session existence
vim.pack.add { vp.gh 'olimorris/persisted.nvim' }
require('persisted').setup {
  before_save = function() require('fyler').close() end,
}
vim.keymap.set('n', '<leader>qs', function() require('persisted').load() end, { desc = 'Restore Session' })
vim.keymap.set('n', '<leader>qS', function() require('persisted').select() end, { desc = 'Select Session' })
vim.keymap.set('n', '<leader>ql', function() require('persisted').load { last = true } end, { desc = 'Restore Last Session' })
vim.keymap.set('n', '<leader>qd', function() require('persisted').stop() end, { desc = "Don't Save Current Session" })

vim.pack.add { vp.gh 'nvimdev/dashboard-nvim' }

local header = [[
        ⢰⡀⠀⣠⠀⠀⠀⠀⠀⠀⢀⣀⠀⠀⠀⠀⠀⢰⡀⢀⡆⠀⠀⠀⢀⡀⠀⠀⠀⠀⣆
⠀⠀⠀⠀⠀⠀⠀⠀⢀⡀⠀⠀⠀⠀⣀⣠⠄⠸⡷⠄⢹⡧⠀⢀⡀⠀⠀⠍⠛⠀⣀⣤⠤⠖⢸⡷⠀⣿⠆⠀⢀⠀⢳⠀⠀⠀⠀⣿⠆⠀⠀⠀⠀⠀⠀⣀
⠀⠀⠀⠀⠀⠀⠀⠀⠭⠛⢁⡠⠚⢉⠀⡖⡄⠀⢷⠀⠸⡇⠀⠀⠻⠀⠀⣠⠔⠋⢁⢠⢰⠀⠀⣧⠀⢸⡄⢠⠂⢀⢠⢠⠀⠴⡦⢸⡄⠀⡠⠁⠀⠷⡼⠁
⠀⠀⠀⠀⢀⡀⡰⡆⠀⠀⠁⠀⠀⠀⠛⠛⠁⠀⢸⡆⠀⣷⠀⠀⠰⢄⠈⠁⠀⠀⠙⠞⠚⠀⠀⢻⠀⠸⡇⠺⠂⠸⡼⠾⠀⠁⠀⠘⣇⠀⣷⠂⠀⠀⣠⣄⡀⢸⣦
⠀⠀⠀⠀⠈⠿⠇⠀⠀⡀⠾⢿⠿⣷⣶⣀⣀⣀⢸⡇⠀⢸⡀⠀⠿⠏⢀⣾⡿⣿⣶⣶⣶⣆⣀⢸⡇⠀⣇⠀⢀⠀⠀⣆⠀⢾⡆⠀⣿⠀⠀⠀⠀⠰⠶⠉⠀⠀⣷⡀
⠀⠀⡐⠁⠀⠀⢁⠀⡼⠛⣦⣤⣤⡶⠛⠋⠛⠉⠁⡇⠀⢸⡇⠀⣤⡀⠀⠻⢦⣀⣠⣼⠿⠛⠁⠸⡇⠀⢻⢀⣾⠃⠀⢻⡄⠘⣧⠀⢻⠀⠀⣤⡄⠀⠀⡠⠀⣀⠘⡧
⠀⠀⡟⠁⠀⡠⠛⠁⣧⡀⠈⢉⠋⠐⠟⠀⠀⠀⢀⡇⡠⠈⡇⠀⠉⠁⣠⣴⢿⢿⣧⠐⠛⢀⠀⣠⠇⢠⢸⢸⢿⠀⠀⢸⣇⠀⢘⡆⢸⠂⣼⠀⠻⠶⠞⠻⠾⠛⠿⠃
⢀⠌⠠⠐⢋⣴⠾⠛⠛⠛⢇⠃⠀⠀⠛⣡⣴⠾⠛⢱⡥⠀⠁⢀⣴⡾⢋⠀⠃⠀⠁⠈⣻⣷⠟⠋⢀⠈⢮⡾⡘⢷⣶⢯⠚⠛⠛⠀⣨⣤⣾⢷⣦⠀⠀⢀⡀⠰⢷
⠸⣦⣤⡴⠛⠁⣴⡴⢷⠀⢸⠀⢀⣠⡾⠋⢠⠃⢠⡀⢀⣠⣴⠟⠋⢠⡁⢸⠀⢀⣴⠟⠉⠀⠀⢠⣂⠀⠀⢀⡟⠃⠀⡆⠀⢀⣴⠞⠋⣰⠁⠀⣀⠔⠁⠁⣠⠴⠚⠋
⠀⠈⠁⠀⠀⠀⠀⠀⠀⠀⠈⠛⠛⠁⠀⠀⠘⠃⠈⠛⠛⠉⠀⠀⠀⠘⠁⠈⠛⠛⠁⠀⠀⠀⠀⠈⠁⠀⠀⠓⠚⠀⠀⠘⠛⠋⠁⠀⠀⠛⠁⠀⠀⠀⠀⠐⠁
]]

local center = {
  { icon = ' ', desc = 'Find File', key = 'f', action = "lua require('fff').find_files()" },
  { icon = ' ', desc = 'New File', key = 'n', action = 'ene | startinsert' },
  { icon = ' ', desc = 'Find Text', key = 'g', action = "lua require('fff').live_grep()" },
  { icon = ' ', desc = 'Recent Files', key = 'r', action = "lua require('mini.pick').start({source={name='Recent Files', items=vim.v.oldfiles}})" },
  { icon = ' ', desc = 'Config', key = 'c', action = "lua require('mini.pick').builtin.files({}, {source={cwd=vim.fn.stdpath('config')}})" },
  { icon = ' ', desc = 'Quit', key = 'q', action = 'qa' },
}
local has_session = vim.fn.filereadable(require('persisted').current()) == 1
if has_session then
  table.insert(center, #center, {
    icon = '󰦛 ',
    desc = 'Restore Session',
    key = 's',
    action = "lua require('persisted').load()",
  })
end
require('dashboard').setup {
  theme = 'doom',
  config = {
    header = vim.split(header, '\n'),
    center = center,
    vertical_center = true,
  },
}
vim.api.nvim_set_hl(0, 'DashboardHeader', { link = 'String' })
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'dashboard' },
  callback = function(ev)
    local win = vim.iter(vim.api.nvim_list_wins()):find(function(w) return vim.api.nvim_win_get_buf(w) == ev.buf end)
    if win then vim.wo[win].fillchars = 'eob: ' end
  end,
})
