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

local function nkeymap(key, map)
    keymap('n', key, map, opts)
end

-- Telescope
nmap('<c-p>', ':Telescope find_files<cr>')

-- LSP
nkeymap('gd', ':lua vim.lsp.buf.definition()<cr>')
nkeymap('gD', ':lua vim.lsp.buf.declaration()<cr>')
nkeymap('gi', ':lua vim.lsp.buf.implementation()<cr>')
nkeymap('gw', ':lua vim.lsp.buf.document_symbol()<cr>')
nkeymap('gw', ':lua vim.lsp.buf.workspace_symbol()<cr>')
nkeymap('gr', ':lua vim.lsp.buf.references()<cr>')
nkeymap('gt', ':lua vim.lsp.buf.type_definition()<cr>')
nkeymap('gk', ':lua vim.lsp.buf.hover()<cr>')
nkeymap('<leader>af', ':lua vim.lsp.buf.code_action()<cr>')
nkeymap('<leader>rn', ':lua vim.lsp.buf.rename()<cr>')

vim.keymap.set('n', '<leader>dc', function() require("nvim-dap").generate_debug_profile() end)
vim.keymap.set('n', '<leader>dh', function() require("dap").toggle_breakpoint() end)
vim.keymap.set('n', '<leader>ds', function()
    require("dap").continue()
    require("NvimTree").close()
end)
vim.keymap.set('n', '<leader>dq', function()
    require("dap").terminate()
    require("dapui").close()
end)
vim.keymap.set('n', '<S-k>', function() require"dap".step_out() end)
vim.keymap.set('n', "<S-l>", function() require"dap".step_into() end)
vim.keymap.set('n', '<S-j>', function() require"dap".step_over() end)
vim.keymap.set('n', '<S-h>', function() require"dap".continue() end)
vim.keymap.set('n', '<leader>di', function() require('dap.ui.widgets').hover() end)
vim.keymap.set('n', '<leader>d?', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.scopes)
end)
vim.keymap.set('n', '<leader>dk', function() require('dap').up() end)
vim.keymap.set('n', '<leader>dj', function() require('dap').down() end)

vim.keymap.set('n', '<leader>dl', function ()
    require('dap.ext.vscode').load_launchjs()
end)

vim.keymap.set('n', '<leader>df', ':Telescope dap frames<CR>')
vim.keymap.set('n', '<leader>db', ':Telescope dap list_breakpoints<CR>')
vim.keymap.set('n', '<leader>du', function() require('dapui').toggle() end)

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
vmap("<leader>/", "gc")  -- Comments the selected lines

nmap("''", "ciw'<Esc>p") -- Quotes the current word with single quotes
nmap('""', 'ciw"<Esc>p') -- Quotes the current word with double quotes
vim.keymap.set("n", "<leader>ss", "<cmd>source ~/.config/nvim/init.lua<CR>")
