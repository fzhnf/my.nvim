-- ============================================================
-- TREE BASED FILE EXPLORER
-- fyler.nvim
-- ============================================================
vim.pack.add { 'https://github.com/FylerOrg/fyler.nvim' }

require('fyler').setup {
  integrations = { icon = 'mini_icons' },
  use_as_default_explorer = true,
  kind = 'split_right_most',
  kind_presets = { split_right_most = { width = '20%' } },
  win_opts = { winhighlight = 'Normal:NormalFloat' },
  extensions = {
    trash = { enabled = true },
    git = { enabled = true },
  },
  mappings = {
    n = {
      ['<leader>E'] = { action = 'close' },
      ['<C-S>'] = { disabled = true },
      ['<C-V>'] = { disabled = true },
      ['s'] = { action = 'select', args = { vsplit = true } },
      ['S'] = { action = 'select', args = { split = true } },
      ['-'] = { action = 'visit', args = { parent = true } },
      -- Copy Path (Y)
      ['Y'] = {
        action = function(self)
          local node = require('fyler.finder').parse_cursor_line(self)
          if node and node.path then
            vim.fn.setreg('+', node.path)
            vim.notify('Copied: ' .. node.path)
          end
        end,
      },
      -- Open with System App (O), default xdg-open
      ['O'] = {
        action = function(self)
          local node = require('fyler.finder').parse_cursor_line(self)
          if node and node.path then
            if vim.ui.open then
              vim.ui.open(node.path)
            else
              vim.cmd('!xdg-open ' .. vim.fn.shellescape(node.path))
            end
          end
        end,
      },
    },
  },
}

local function fyler_toggle()
  return function()
    local finder = require 'fyler.finder'
    local inst = finder.instance_get_or_nil()
    if not inst then
      require('fyler').open { root_path = vim.uv.cwd() }
    elseif inst.win_id == vim.api.nvim_get_current_win() then
      require('fyler').close()
    else
      vim.api.nvim_set_current_win(inst.win_id)
    end
  end
end

vim.keymap.set('n', '<leader>e', fyler_toggle(), { desc = 'Explorer Fyler' })

-- ============================================================
-- SEARCH & NAVIGATION
-- fff & leap.nvim
-- ============================================================
-- FFF
vim.pack.add { 'https://github.com/dmtrKovalenko/fff' }

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'fff' and (kind == 'install' or kind == 'update') then
      if not ev.data.active then vim.cmd.packadd 'fff' end
      require('fff.download').download_or_build_binary()
    end
  end,
})

vim.g.fff = {
  lazy_sync = true,
  debug = { enabled = false, show_scores = false },
}

vim.keymap.set('n', 'ff', function() require('fff').find_files() end, { desc = 'FFFind files' })
vim.keymap.set('n', 'fg', function() require('fff').live_grep() end, { desc = 'LiFFFe grep' })
vim.keymap.set({ 'n', 'x' }, 'fw', function() require('fff').live_grep_under_cursor() end, { desc = 'Search current word / selection' })
vim.keymap.set('n', 'fz', function() require('fff').live_grep { grep = { modes = { 'fuzzy', 'plain' } } } end, { desc = 'Live fffuzy grep' })

-- <leader> mappings for fff (telescope migration)
vim.keymap.set('n', '<leader>sf', function() require('fff').find_files() end, { desc = '[S]earch [F]iles (fff)' })
vim.keymap.set('n', '<leader>sg', function() require('fff').live_grep() end, { desc = '[S]earch by [G]rep (fff)' })
vim.keymap.set({ 'n', 'v' }, '<leader>sw', function() require('fff').live_grep_under_cursor() end, { desc = '[S]earch current [W]ord (fff)' })

-- LEAP.NVIM
vim.pack.add { 'https://codeberg.org/andyg/leap.nvim' }
require('leap').opts.preview = false
require('leap.user').set_backdrop_highlight 'Comment'

vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap)')
vim.keymap.set('n', 'S', '<Plug>(leap-from-window)')

-- Visit (jump - operate - jump back)
vim.keymap.set({ 'n', 'x', 'o' }, 'gs', '<Plug>(leap-visit)')
vim.keymap.set({ 'x', 'o' }, 'ar', '<Plug>(leap-visit-text-object)')
vim.keymap.set({ 'x', 'o' }, 'ir', '<Plug>(leap-visit-inner-text-object)')

vim.keymap.set('o', 'rr', function() -- "visit line" shortcut
  return (vim.v.count == 0 and '1' or '') .. '<Plug>(leap-visit)'
end, { expr = true })

-- Automatic paste on return.
vim.api.nvim_create_autocmd('User', {
  pattern = 'VisitDone',
  group = vim.api.nvim_create_augroup('Visit', {}),
  callback = function(event)
    if (event.data.mode:match '^[vV\22]' or (vim.v.operator == 'y')) and event.data.register == '"' then vim.cmd 'normal! p' end
  end,
})

-- Treeselect
vim.keymap.set({ 'x', 'o' }, 'an', function()
  require('leap.treesitter').select {
    opts = require('leap.user').with_traversal_keys('n', 'N'),
  }
end)

-- ============================================================
-- FIND & REPLACE
-- grug-far.nvim
-- ============================================================
vim.pack.add { 'https://github.com/MagicDuck/grug-far.nvim' }
require('grug-far').setup { headerMaxWidth = 80 }
vim.keymap.set('n', '<leader>sr', function()
  local grug = require 'grug-far'
  local ext = vim.bo.buftype == '' and vim.fn.expand '%:e'
  grug.open {
    transient = true,
    prefills = {
      filesFilter = ext and ext ~= '' and '*.' .. ext or nil,
    },
  }
end, { desc = 'Explorer Fyler' })
