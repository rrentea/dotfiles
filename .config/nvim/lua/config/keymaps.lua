-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  Move focus with tmux support
vim.keymap.set('n', '<A-h>', function() require("tmux").move_left() end, { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<A-l>', function() require("tmux").move_right() end, { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<A-j>', function() require("tmux").move_bottom() end, { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<A-k>', function() require("tmux").move_top() end, { desc = 'Move focus to the upper window' })

--  Resize with tmux supprt
vim.keymap.set('n', '<C-A-h>', function() require("tmux").resize_left() end, { desc = 'Resize to left' })
vim.keymap.set('n', '<C-A-l>', function() require("tmux").resize_right() end, { desc = 'Resize to right' })
vim.keymap.set('n', '<C-A-j>', function() require("tmux").resize_bottom() end, { desc = 'Resize to lower' })
vim.keymap.set('n', '<C-A-k>', function() require("tmux").resize_top() end, { desc = 'Resize to upper' })

-- Misc
vim.keymap.set('i', 'jk', '<esc>l', { desc = 'Exit insert mode by pressing jk' })
vim.keymap.set('i', 'JK', '<esc>l', { desc = 'Exit insert mode by pressing jk' })
vim.keymap.set('i', 'Jk', '<esc>l', { desc = 'Exit insert mode by pressing jk' })
vim.keymap.set('i', 'jK', '<esc>l', { desc = 'Exit insert mode by pressing jk' })
vim.keymap.set('i', 'kj', '<esc>l', { desc = 'Exit insert mode by pressing jk' })
vim.keymap.set('i', 'kJ', '<esc>l', { desc = 'Exit insert mode by pressing jk' })
vim.keymap.set('i', 'Kj', '<esc>l', { desc = 'Exit insert mode by pressing jk' })
vim.keymap.set('n', '<C-p>', '<cmd>!t<cr>', { desc = 'Tmux new or switch session' })
