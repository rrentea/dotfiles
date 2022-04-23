vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.autoread = true


vim.cmd [[set nofoldenable]]
vim.cmd [[set clipboard=unnamedplus]]

-- Showing line numbers

vim.cmd [[ set number ]]

require('vimspector').setup()

-- Feline

vim.cmd [[let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"]]
vim.cmd [[let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"]]
vim.cmd [[ set termguicolors ]]

require("feline").setup({
	components = require('catppuccin.core.integrations.feline'),
})

-- Color Scheme

vim.cmd [[ colorscheme catppuccin ]]

local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
    local opts = {}
    if server.name == "sumneko_lua" then
        opts = {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim', 'use' }
                    },
                }
            }
        }
    end
    server:setup(opts)
end)

-- Setup autopairs
-- If you want insert `(` after select function or method item
-- local cmp_autopairs = require('nvim-autopairs.completion.cmp')
-- cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))


-- add a lisp filetype (wrap my-function), FYI: Hardcoded = { "clojure", "clojurescript", "fennel", "janet" }
-- cmp_autopairs.lisp[#cmp_autopairs.lisp+1] = "racket"

-- Appearance
---------------------------------------------------------
vim.o.termguicolors = true
vim.opt.number = true -- show line numbers
vim.opt.mouse = "a"
vim.opt.wrap = false 
vim.opt.linebreak = true -- set soft wrapping
vim.opt.showbreak = "↪"
vim.opt.autoindent = true -- automatically set indent of new line
vim.opt.ttyfast = true -- faster redrawing
table.insert(vim.opt.diffopt, "vertical")
table.insert(vim.opt.diffopt, "iwhite")
table.insert(vim.opt.diffopt, "internal")
table.insert(vim.opt.diffopt, "algorithm:patience")
table.insert(vim.opt.diffopt, "hiddenoff")
vim.opt.laststatus = 2 -- show the status line all the time
vim.opt.scrolloff = 7 -- set 7 lines to the cursors - when moving vertical
vim.opt.wildmenu = true -- enhanced command line completion
vim.opt.hidden = true -- current buffer can be put into background
vim.opt.showcmd = true -- show incomplete commands
vim.opt.showmode = true -- don't show which mode disabled for PowerLine
vim.opt.wildmode = {"list", "longest"} -- complete files like a shell
vim.opt.shell = vim.env.SHELL
vim.opt.cmdheight = 1 -- command bar height
vim.opt.title = true -- set terminal title
vim.opt.showmatch = true -- show matching braces
vim.opt.mat = 2 -- how many tenths of a second to blink
vim.opt.updatetime = 300
vim.opt.signcolumn = "yes"
vim.opt.shortmess = "atToOFc" -- prompt message options
vim.opt.laststatus = 3 -- Global status line

-- Tab control
vim.opt.smarttab = true -- tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
vim.opt.tabstop = 4 -- the visible width of tabs
vim.opt.softtabstop = 4 -- edit as if the tabs are 4 characters wide
vim.opt.shiftwidth = 4 -- number of spaces to use for indent and unindent
vim.opt.shiftround = true -- round indent to a multiple of 'shiftwidth'

vim.opt.backup = false -- don't use backup files
vim.opt.writebackup = false -- don't backup the file while editing
vim.opt.swapfile = false -- don't create swap files for new buffers
vim.opt.updatecount = 0 -- don't write swap files after some number of updates

-- Disable text diagnostics
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--     vim.lsp.diagnostic.on_publish_diagnostics, {
--         virtual_text = false
--     }
-- )
vim.lsp.handlers['textDocument/publishDiagnostics'] = function() end

vim.g.asyncrun_open = 6
vim.g.asynctasks_term_pos = 'bottom'
vim.g.asynctasks_term_rows = 10   -- set height for the horizontal terminal split
vim.g.asynctasks_term_cols = 80   -- set width for vertical terminal split
