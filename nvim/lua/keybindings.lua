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

-- Trouble linting config
vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>Trouble loclist<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "gR", "<cmd>Trouble lsp_references<cr>",
  {silent = true, noremap = true}
)

-- Window management
nmap("<a-|>", ":vs<cr>") -- I actually want to map this to ctrl+shift+|, but I can't do that for some reason
nmap("<a-_>", ":sp<cr>")

nmap("<leader>q", ":q<cr>")

-- Running current python file
nmap("<F5>", ":sp <CR> :term python % <CR>")

-- Miscellanious
imap("jk", "<Esc>")
nmap("<leader>,", ":w<cr>")
nmap("<leader>/", "gcc") -- Comments the current line
vmap("<leader>/", "gc")  -- Comments the selected lines
