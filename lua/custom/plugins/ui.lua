local vp = require 'custom.util.vimpack_helper'

vim.pack.add { vp.gh 'nvim-mini/mini.tabline' }

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

-- Simple and easy statusline.
vim.pack.add { vp.gh 'nvim-mini/mini.statusline' }

--  You could remove this setup call if you don't like it,
--  and try some other statusline plugin
local statusline = require 'mini.statusline'
-- Set `use_icons` to true if you have a Nerd Font
statusline.setup { use_icons = vim.g.have_nerd_font }

-- You can configure sections in the statusline by overriding their
-- default behavior. For example, here we set the section for
-- cursor location to LINE:COLUMN
---@diagnostic disable-next-line: duplicate-set-field
statusline.section_location = function() return '%S %2l:%-2v' end

-- Show macro recording (q..q) in the mode section
local section_mode = statusline.section_mode
---@diagnostic disable-next-line: duplicate-set-field
statusline.section_mode = function(args)
  local mode, hl = section_mode(args)
  local reg = vim.fn.reg_recording()
  if reg ~= '' then return mode .. ' 󰆃 ' .. reg, hl end
  return mode, hl
end

require('vim._core.ui2').enable {}
vim.pack.add { vp.gh 'rachartier/tiny-cmdline.nvim' }

---@diagnostic disable-next-line: missing-fields
require('tiny-cmdline').setup {
  on_reposition = require('tiny-cmdline').adapters.blink,
}

-- If a nerd font is available, load the icons module for pretty icons in various plugins.
--
if vim.g.have_nerd_font then
  vim.pack.add { vp.gh 'nvim-mini/mini.icons' }
  require('mini.icons').setup()
  -- Used for backwards compatibility with plugins that require `nvim-web-devicons` (e.g. telescope.nvim)
  MiniIcons.mock_nvim_web_devicons()
end

if vim.fn.argc() == 0 then
  vim.pack.add { vp.gh 'nvimdev/dashboard-nvim', vp.gh 'nvim-mini/mini.pick' }

  local persisted_ok, persisted = pcall(require, 'persisted')
  local has_session = persisted_ok and vim.fn.filereadable(persisted.current()) == 1
  local picker = require 'mini.pick'

  local center = {
    { icon = '󰈞  ', desc = 'Find File', key = 'f', action = function() require('fff').find_files() end },
    { icon = '󰝒  ', desc = 'New File', key = 'n', action = function() vim.cmd.enew() end },
    { icon = '󰱼  ', desc = 'Find Text', key = 'g', action = function() require('fff').live_grep() end },
    {
      icon = '󰄉  ',
      desc = 'Recent Files',
      key = 'r',
      action = function() picker.start { source = { name = 'Recent Files', items = vim.v.oldfiles } } end,
    },
    {
      icon = '󰒓  ',
      desc = 'Config',
      key = 'c',
      action = function() picker.builtin.files({}, { source = { cwd = vim.fn.stdpath 'config' } }) end,
    },
    { icon = '󰈆  ', desc = 'Quit', key = 'q', action = 'q' },
  }
  if has_session then
    table.insert(center, #center, {
      icon = '󰦛  ',
      desc = 'Restore Session',
      key = 's',
      action = function() persisted.load() end,
    })
  end

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
  require('dashboard').setup {
    theme = 'doom',
    config = {
      header = vim.split(header, '\n'),
      center = center,
      vertical_center = true,
    },
  }
  vim.api.nvim_set_hl(0, 'DashboardHeader', { link = 'String' })
  vim.api.nvim_set_hl(0, 'DashboardIcon', { link = 'Type' })
  vim.api.nvim_set_hl(0, 'DashboardDesc', { link = 'Function' })
  vim.api.nvim_set_hl(0, 'DashboardKey', { link = 'Keyword' })
  vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'dashboard' },
    callback = function(ev)
      local win = vim.iter(vim.api.nvim_list_wins()):find(function(w) return vim.api.nvim_win_get_buf(w) == ev.buf end)
      if win then vim.wo[win].fillchars = 'eob: ' end
    end,
  })
end

vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
  callback = function(args)
    vim.api.nvim_del_autocmd(args.id)

    -- Useful status updates for LSP.
    vim.pack.add { vp.gh 'j-hui/fidget.nvim' }
    require('fidget').setup {}

    -- Add indentation guides even on blank lines

    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    vim.pack.add { vp.gh 'lukas-reineke/indent-blankline.nvim' }
    require('ibl').setup { exclude = { filetypes = { 'dashboard' } } }
  end,
})
