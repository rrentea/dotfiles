local g = vim.g
local utils = require("utils")
local nmap = utils.nmap
local vmap = utils.vmap
local imap = utils.imap
g.mapleader = ","

local keymap = vim.api.nvim_set_keymap
keymap('n', '<C-s>', ':w<CR>', {})
keymap('i', '<C-s>', '<ESC>:w<CR>a', {})
nmap("<leader>,", ":w<cr>")

nmap("<enter>", "o<Esc>")
nmap("<S-enter>", "O<Esc>")

nmap('<a-j>', '<C-w>j')
nmap('<a-h>', '<C-w>h')
nmap('<a-k>', '<C-w>k')
nmap('<a-l>', '<c-w>l')
nmap('<c-a-h>', '<c-w><')
nmap('<c-a-j>', '<c-w>+')
nmap('<c-a-k>', '<c-w>-')
nmap('<c-a-l>', '<c-w>>')

-- Nvim Tree
nmap('<leader>t', ':NvimTreeToggle<CR>')
nmap('<leader>f', ':NvimTreeFindFile<CR>')

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
    require("dapui").close()
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
vim.keymap.set('n', '<leader>du', function() require('dapui').toggle() end)
----------------------------------
----------DEBUG BINDINGS----------
----------------------------------

-- LazyGit
nmap("<leader>g", ":LazyGit<cr>")

-- Window management
nmap("<a-|>", ":vs<cr>")
nmap("<a-_>", ":sp<cr>")
nmap("<leader>q", ":q<cr>")

vim.keymap.set('n', '<leader>sj', ':call WindowSwap#MarkWindowSwap()<CR><c-w>j:call WindowSwap#DoWindowSwap()<CR>')
vim.keymap.set('n', '<leader>sk', ':call WindowSwap#MarkWindowSwap()<CR><c-w>k:call WindowSwap#DoWindowSwap()<CR>')
vim.keymap.set('n', '<leader>sh', ':call WindowSwap#MarkWindowSwap()<CR><c-w>h:call WindowSwap#DoWindowSwap()<CR>')
vim.keymap.set('n', '<leader>sl', ':call WindowSwap#MarkWindowSwap()<CR><c-w>l:call WindowSwap#DoWindowSwap()<CR>')

-- Treesitter selection
vim.cmd[[omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>]]
vim.cmd[[vnoremap <silent> m :lua require('tsht').nodes()<CR>]]

-- Running and building code
nmap("<F1>", ":AsyncTask project-run<cr>")
nmap("<C-b>", ":AsyncTask project-build<cr>")

-- Miscellanious
imap("jk", "<Esc>")
nmap("<leader>,", ":w!<cr>")
nmap("<leader>/", "gcc") -- Comments the current line
vmap("<leader>/", "gc") -- Comments the selected lines
vim.keymap.set('i', '<S-enter>', '<C-o>o')

nmap("''", "ciw'<Esc>p") -- Quotes the current word with single quotes
nmap('""', 'ciw"<Esc>p') -- Quotes the current word with double quotes
vim.keymap.set("n", "<leader>ss", "<cmd>source ~/.config/nvim/init.lua<CR>")
