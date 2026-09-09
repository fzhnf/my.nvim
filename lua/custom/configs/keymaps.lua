-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- GENERAL
-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- update file only writes when the buffer changed
vim.keymap.set({ 'n', 'i', 'x' }, '<C-s>', '<cmd>update<CR>', { desc = 'Save file' })

-- BUFFERS
vim.keymap.set('n', '[b', '<cmd>bprevious<CR>', { desc = 'Prev [B]uffer' })
vim.keymap.set('n', ']b', '<cmd>bnext<CR>', { desc = 'Next [B]uffer' })
vim.keymap.set('n', '<leader>bb', '<C-^>', { desc = 'Switch to Other [B]uffer' })
vim.keymap.set('n', '<leader>bd', '<cmd>bd<CR>', { desc = 'Delete [B]uffer' })
vim.keymap.set('n', '<leader>bo', '<cmd>%bd|e#<CR>', { desc = 'Delete Other [B]uffers' })

-- WINDOWS
-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
vim.keymap.set('n', '<C-S-h>', '<C-w>H', { desc = 'Move window to the left' })
vim.keymap.set('n', '<C-S-l>', '<C-w>L', { desc = 'Move window to the right' })
vim.keymap.set('n', '<C-S-j>', '<C-w>J', { desc = 'Move window to the lower' })
vim.keymap.set('n', '<C-S-k>', '<C-w>K', { desc = 'Move window to the upper' })

vim.keymap.set('n', '<leader>-', '<cmd>split<CR>', { desc = 'Split Window Below' })
vim.keymap.set('n', '<leader>|', '<cmd>vsplit<CR>', { desc = 'Split Window Right' })

-- DIAGNOSTICS & QUICKFIX
--  See `:help vim.diagnostic.Opts`
vim.diagnostic.config {
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = { min = vim.diagnostic.severity.WARN } },

  -- Can switch between these as you prefer
  virtual_text = true, -- Text shows up at the end of the line
  virtual_lines = false, -- Text shows up underneath the line, with virtual lines

  -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
  jump = {
    on_jump = function(_, bufnr)
      vim.diagnostic.open_float {
        bufnr = bufnr,
        scope = 'cursor',
        focus = false,
      }
    end,
  },
}

vim.keymap.set('n', '<leader>xl', vim.diagnostic.setloclist, { desc = 'Diagnostic [L]ocation list' })
vim.keymap.set('n', '<leader>xq', '<cmd>copen<CR>', { desc = 'Open [Q]uickfix list' })
vim.keymap.set('n', '[q', '<cmd>cprev<CR>', { desc = 'Previous [Q]uickfix' })
vim.keymap.set('n', ']q', '<cmd>cnext<CR>', { desc = 'Next [Q]uickfix' })
vim.keymap.set('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Line [D]iagnostics' })

-- UI TOGGLES
vim.keymap.set('n', '<leader>ul', function() vim.wo.number = not vim.wo.number end, { desc = 'Toggle [l]ine numbers' })
vim.keymap.set('n', '<leader>uL', function() vim.wo.relativenumber = not vim.wo.relativenumber end, { desc = 'Toggle relative [l]ine numbers' })
vim.keymap.set('n', '<leader>uw', '<cmd>set wrap!<CR>', { desc = 'Toggle [W]rap' })
vim.keymap.set('n', '<leader>us', '<cmd>set spell!<CR>', { desc = 'Toggle [S]pelling' })
vim.keymap.set('n', '<leader>ur', '<cmd>nohlsearch<Bar>diffupdate<CR><C-L>', { desc = 'Redraw / clear hlsearch / diff update' })

-- GIT
vim.keymap.set('n', '<leader>gg', function() require('custom.util.terminal').lazygit() end, { desc = 'Toggle Lazygit' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')
