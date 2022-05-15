local g = vim.g
g.mapleader = ","

vim.keymap.set('n', '<C-s>', ':w<CR>')
vim.keymap.set('i', '<C-s>', '<ESC>:w<CR>a')
vim.keymap.set('n', "<leader>,", ":w<cr>")

vim.keymap.set('n', "<enter>", "o<Esc>")
vim.keymap.set('n', "<S-enter>", "O<Esc>")

vim.keymap.set('n', '<a-j>', '<C-w>j')
vim.keymap.set('n', '<a-h>', '<C-w>h')
vim.keymap.set('n', '<a-k>', '<C-w>k')
vim.keymap.set('n', '<a-l>', '<c-w>l')
vim.keymap.set('n', '<c-a-h>', '<c-w><')
vim.keymap.set('n', '<c-a-j>', '<c-w>+')
vim.keymap.set('n', '<c-a-k>', '<c-w>-')
vim.keymap.set('n', '<c-a-l>', '<c-w>>')

-- Nvim Tree
vim.keymap.set('n', '<leader>t', ':NvimTreeToggle<CR>')
vim.keymap.set('n', '<leader>f', ':NvimTreeFindFile<CR>')


-- Telescope
vim.keymap.set('n', '<c-p>', '<cmd>Telescope find_files hidden=true<cr>')
vim.keymap.set('n', '<c-f>', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', '<c-s>', '<cmd>Telescope current_buffer_fuzzy_find<cr>')

----------------------------------
----------DEBUG BINDINGS----------
----------------------------------
vim.keymap.set('n', '<leader>dc', function() require("nvim-dap").generate_debug_profile() end)
vim.keymap.set('n', '<leader>dh', function() require("dap").toggle_breakpoint() end)

-- When starting debugging I always want to use the config in launch.json
-- I never want to debug without a configuration
-- It should be consistent when launch.json is changed and I don't have to think about it
vim.keymap.set('n', '<leader>ds', function()
    require('dap').configurations.python = {} -- Clearing any current configuration
    require('dap').configurations.cpp = {} -- Clearing any current configuration
    require('dap.ext.vscode').load_launchjs(nil, { cppdbg = {'c', 'cpp'} })
    require("dap").continue()
    require("nvim-tree.view").close()
end)
vim.keymap.set('n', '<leader>dq', function()
    require("dap").terminate()
    require("dapui").close(nil)
end)
vim.keymap.set('n', '<S-k>', function() require "dap".step_out() end)
vim.keymap.set('n', "<S-l>", function() require "dap".step_into() end)
vim.keymap.set('n', '<S-j>', function() require "dap".step_over() end)
vim.keymap.set('n', '<S-h>', function() require "dap".continue() end)
vim.keymap.set('n', '<leader>di', function() require('dapui').eval(nil, { enter = true }) end)
vim.keymap.set('n', '<leader>d?', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.scopes)
end)
vim.keymap.set('n', '<leader>dk', function() require('dap').up() end)
vim.keymap.set('n', '<leader>dj', function() require('dap').down() end)

vim.keymap.set('n', '<leader>dl', function()
    require('dap.ext.vscode').load_launchjs()
end)

vim.keymap.set('n', '<leader>df', ':Telescope dap frames<CR>')
vim.keymap.set('n', '<leader>db', ':Telescope dap list_breakpoints<CR>')
vim.keymap.set('n', '<leader>du', function() require('dapui').toggle(nil) end)

-- LazyGit
vim.keymap.set('n', "<leader>g", ":LazyGit<cr>")

-- Window management
vim.keymap.set('n', "<a-|>", ":vs<cr>")
vim.keymap.set('n', "<a-_>", ":sp<cr>")
vim.keymap.set('n', "<leader>q", ":q<cr>")
vim.keymap.set('n', '<leader>Q', ':qa<CR>')

vim.keymap.set('n', '<leader>sj', ':call WindowSwap#MarkWindowSwap()<CR><c-w>j:call WindowSwap#DoWindowSwap()<CR>')
vim.keymap.set('n', '<leader>sk', ':call WindowSwap#MarkWindowSwap()<CR><c-w>k:call WindowSwap#DoWindowSwap()<CR>')
vim.keymap.set('n', '<leader>sh', ':call WindowSwap#MarkWindowSwap()<CR><c-w>h:call WindowSwap#DoWindowSwap()<CR>')
vim.keymap.set('n', '<leader>sl', ':call WindowSwap#MarkWindowSwap()<CR><c-w>l:call WindowSwap#DoWindowSwap()<CR>')

-- Treesitter selection
vim.cmd[[omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>]]
vim.cmd[[vnoremap <silent> m :lua require('tsht').nodes()<CR>]]

-- Running and building code
vim.keymap.set('n', "<F1>", ":AsyncTask project-run<cr>")
vim.keymap.set('n', "<C-b>", ":AsyncTask project-build<cr>")

-- Moving lines up and down
vim.keymap.set('v', '<S-j>', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', '<S-k>', ":m '<-2<CR>gv=gv")

-- Miscellanious
vim.keymap.set('i', "jk", "<Esc>")
vim.keymap.set('n', "<leader>,", ":w!<cr>")
vim.keymap.set('n', "<leader>/", "gcc") -- Comments the current line
vim.keymap.set('v', "<leader>/", "gc") -- Comments the selected lines
vim.keymap.set('i', '<S-enter>', '<C-o>o')

vim.keymap.set('n', "''", "ciw'<Esc>p") -- Quotes the current word with single quotes
vim.keymap.set('n', '""', 'ciw"<Esc>p') -- Quotes the current word with double quotes
-- vim.keymap.set("n", "<leader>ss", "<cmd>source ~/.config/nvim/init.lua<CR>")
