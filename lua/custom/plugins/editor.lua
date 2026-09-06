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
