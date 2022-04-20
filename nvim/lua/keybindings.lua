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

-- Window movement and resizing (Rizesing is not quite as I want it to be)
nmap('<a-j>', '<C-w>j')
nmap('<a-h>', '<C-w>h')
nmap('<a-k>', '<C-w>k')
nmap('<a-l>', '<c-w>l')
nmap('<a-s-h>', '<c-w><')
nmap('<a-s-j>', '<c-w>+')
nmap('<a-s-k>', '<c-w>-')
nmap('<a-s-l>', '<c-w>>')
nmap('<leader>h', ':WinShift left<cr>')
nmap('<leader>j', ':WinShift down<cr>')
nmap('<leader>k', ':WinShift up<cr>')
nmap('<leader>l', ':WinShift right<cr>')

-- Nerd Tree
keymap('n', '<leader>n', ':NERDTree<CR>', {})
keymap('n', '<leader>t', ':NERDTreeToggle<CR>', {})
keymap('n', '<leader>f', ':NERDTreeFind<CR>', {})

local function nkeymap(key, map)
    keymap('n', key, map, opts)
end

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

-- LazyGit
nmap("<leader>g", ":LazyGit<cr>")

-- Window management
nmap("<a-|>", ":vs<cr>")
nmap("<a-_>", ":sp<cr>")

nmap("<leader>q", ":q<cr>")

-- Running current file
nmap("<F1>", "<cmd>RunCode<cr>")

-- Debug config
nmap("<leader>dc", "<cmd>lua require('vimspector').generate_debug_profile()<cr>")
-- nmap("<F5>", "<Plug>VimspectorContinue<cr>")
-- nmap("<F3>", "<Plug>VimspectorStop<cr>")
-- nmap("<F4>", "<Plug>VimspectorRestart<cr>")
-- nmap("<F6>", "<Plug>VimspectorPause<cr>")
nmap("<leader>db", "<Plug>VimspectorToggleBreakPoint<cr>")
-- nmap("<leader><F9>", "<Plug>VimspectorToggleConditionalBreakpoint<cr>")
-- nmap("<F8>", "<Plug>VimspectorAddFunctionBreakpoint<cr>")
-- nmap("<leader><F8>", "<Plug>VimspectorRunToCursor<cr>")
-- nmap("<F10>", "<Plug>VimspectorStepOver<cr>")
-- nmap("<F11>", "<Plug>VimspectorStepInto<cr>")
-- nmap("<F12>", "<Plug>VimspectorStepOut<cr>")

-- Miscellanious
imap("jk", "<Esc>")
nmap("<leader>,", ":w<cr>")
nmap("<leader>/", "gcc") -- Comments the current line
vmap("<leader>/", "gc")  -- Comments the selected lines

nmap("''", "ciw'<Esc>p") -- Quotes the current word with single quotes
nmap('""', 'ciw"<Esc>p') -- Quotes the current word with double quotes

