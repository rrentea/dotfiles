local opt = vim.opt
local cmd = vim.cmd
local g = vim.g
local o = vim.o
local fn = vim.fn
local env = vim.env
local utils = require("utils")
local termcodes = utils.termcodes
local nmap = utils.nmap
local vmap = utils.vmap
local imap = utils.imap
local xmap = utils.xmap
local omap = utils.omap
local nnoremap = utils.nnoremap
local inoremap = utils.inoremap
local vnoremap = utils.vnoremap
g.mapleader = ","

local keymap = vim.api.nvim_set_keymap
keymap('n', '<C-s>', ':w<CR>', {})
keymap('i', '<C-s>', '<ESC>:w<CR>a', {})
nmap("<leader>,", ":w<cr>")

nmap("<enter>", "o<Esc>")
nmap("<S-enter>", "O<Esc>")

local opts = { noremap = true }

nmap('<a-j>', '<C-w>j')
nmap('<a-h>', '<C-w>h')
nmap('<a-k>', '<C-w>k')
nmap('<a-l>', '<c-w>l')
nmap('<a-s-h>', '<c-w><')
nmap('<a-s-j>', '<c-w>+')
nmap('<a-s-k>', '<c-w>-')
nmap('<a-s-l>', '<c-w>>')

-- Nvim Tree
nmap('<leader>t', ':NvimTreeToggle<CR>')
nmap('<leader>f', ':NvimTreeFindFile<CR>')

-- Telescope
nmap('<c-p>', ':Telescope find_files<cr>')

----------------------------------
----------DEBUG BINDINGS----------
----------------------------------
vim.keymap.set('n', '<leader>dc', function() require("nvim-dap").generate_debug_profile() end)
vim.keymap.set('n', '<leader>dh', function() require("dap").toggle_breakpoint() end)

-- When starting debugging I always want to use the config in launch.json
-- I never want to debug without a configuration
-- It should be consistent when launch.json is changed and I don't have to think about it
vim.keymap.set('n', '<leader>ds', function()
    -- local count = 0
    -- for _ in pairs(require('dap').configurations.python) do
    --     count = count + 1
    -- end
    -- if count == 0 then
    --     print('got here')
    --     require('dap.ext.vscode').load_launchjs()
    -- end
    require('dap').configurations.python = {} -- Clearing any current configuration
    require('dap.ext.vscode').load_launchjs()
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

-- Running and building code
nmap("<F1>", ":AsyncTask file-run<cr>")
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
