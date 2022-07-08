local g = vim.g
g.mapleader = ","

vim.keymap.set('n', '<C-s>', ':w<CR>')
vim.keymap.set('i', '<C-s>', '<ESC>:w<CR>a')
vim.keymap.set('n', "<leader>,", ":w<cr>")

vim.keymap.set('n', "<enter>", "o<Esc>")
vim.keymap.set('n', "<S-enter>", "O<Esc>")

vim.keymap.set('n', '<a-j>', function() require('winmove').winmove('j') end)
vim.keymap.set('n', '<a-h>', function() require('winmove').winmove('h') end)
vim.keymap.set('n', '<a-k>', function() require('winmove').winmove('k') end)
vim.keymap.set('n', '<a-l>', function() require('winmove').winmove('l') end)

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
local dap = require("dap")
vim.keymap.set('n', '<leader>dh', function() dap.toggle_breakpoint() end)

-- When starting debugging I always want to use the config in launch.json
-- I never want to debug without a configuration
-- It should be consistent when launch.json is changed and I don't have to think about it
vim.keymap.set('n', '<leader>ds', function()
    dap.configurations.python = {} -- Clearing any current configuration
    dap.configurations.cpp = {} -- Clearing any current configuration
    require('dap.ext.vscode').load_launchjs(os.getenv("PWD") .. "/.nvim/launch.json", { cppdbg = {'c', 'cpp'} })
    dap.continue()
    require("nvim-tree.view").close()
end)
vim.keymap.set('n', '<leader>dq', function()
    dap.terminate()
    require("dapui").close(nil)
end)
vim.keymap.set('n', '<S-k>', function() dap.step_out() end)
vim.keymap.set('n', "<S-l>", function() dap.step_into() end)
vim.keymap.set('n', '<S-j>', function() dap.step_over() end)
vim.keymap.set('n', '<S-h>', function() dap.continue() end)
vim.keymap.set('n', '<leader>di', function() require('dapui').eval(nil, { enter = true }) end)
vim.keymap.set('n', '<leader>d?', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.scopes)
end)
vim.keymap.set('n', '<leader>dk', function() dap.up() end)
vim.keymap.set('n', '<leader>dj', function() dap.down() end)
vim.keymap.set('n', '<leader>dc', function() dap.run_to_cursor() end)

vim.keymap.set('n', '<leader>dl', function()
    require('dap.ext.vscode').load_launchjs()
end)

vim.keymap.set('n', '<leader>df', ':Telescope dap frames<CR>')
vim.keymap.set('n', '<leader>db', ':Telescope dap list_breakpoints<CR>')
vim.keymap.set('n', '<leader>du', function() require('dapui').toggle(nil) end)

-- LazyGit
vim.keymap.set('n', "<leader>g", ":LazyGit<cr>")

-- Window management
vim.keymap.set('n', "<leader>v", ":vs<cr>")
vim.keymap.set('n', "<leader>x", ":sp<cr>")
vim.keymap.set('n', "<a-q>", ":q<cr>")
vim.keymap.set('n', '<leader>Q', ':qa<CR>')

vim.keymap.set('n', '<leader>sj', ':call WindowSwap#MarkWindowSwap()<CR><c-w>j:call WindowSwap#DoWindowSwap()<CR>')
vim.keymap.set('n', '<leader>sk', ':call WindowSwap#MarkWindowSwap()<CR><c-w>k:call WindowSwap#DoWindowSwap()<CR>')
vim.keymap.set('n', '<leader>sh', ':call WindowSwap#MarkWindowSwap()<CR><c-w>h:call WindowSwap#DoWindowSwap()<CR>')
vim.keymap.set('n', '<leader>sl', ':call WindowSwap#MarkWindowSwap()<CR><c-w>l:call WindowSwap#DoWindowSwap()<CR>')

-- Treesitter selection
vim.cmd[[omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>]]
vim.cmd[[vnoremap <silent> m :lua require('tsht').nodes()<CR>]]

-- Syntax tree surfer

-- Normal Mode Swapping:
-- Swap The Master Node relative to the cursor with it's siblings, Dot Repeatable
vim.keymap.set('n', '<leader>vk', function ()
    vim.opt.opfunc = 'v:lua.STSSwapUpNormal_Dot'
    return "g@l"
end, { silent = true, expr = true })

vim.keymap.set('n', '<leader>vj', function ()
    vim.opt.opfunc = 'v:lua.STSSwapDownNormal_Dot'
    return "g@l"
end, { silent = true, expr = true })

-- Swap Current Node at the Cursor with it's siblings, Dot Repeatable
vim.keymap.set('n', '<leader>vl', function()
	vim.opt.opfunc = 'v:lua.STSSwapCurrentNodeNextNormal_Dot'
	return 'g@l'
end, { silent = true, expr = true })
vim.keymap.set('n', '<leader>vh', function()
	vim.opt.opfunc = 'v:lua.STSSwapCurrentNodePrevNormal_Dot'
	return 'g@l'
end, { silent = true, expr = true })

-- Running and building code
vim.keymap.set('n', "<F1>", ":AsyncTask project-run<cr>")
vim.keymap.set('n', "<C-b>", ":AsyncTask project-build<cr>")

-- Moving lines up and down
vim.keymap.set('v', '<S-j>', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', '<S-k>', ":m '<-2<CR>gv=gv")

-- Spectre
vim.keymap.set('n', '<leader>ss', function() require('spectre').open() end)
vim.keymap.set('n', '<leader>sw', function() require('spectre').open_visual({selected_word=true}) end)

-- Miscellanious
vim.keymap.set('i', "jk", "<Esc>")
vim.keymap.set('n', "<leader>,", ":w!<cr>")
vim.keymap.set('n', "<leader>/", "gcc") -- Comments the current line
vim.keymap.set('v', "<leader>/", "gc") -- Comments the selected lines
vim.keymap.set('i', '<S-enter>', '<C-o>o')
vim.keymap.set('v', '"', 's"<Esc>pa"')
vim.keymap.set('v', "'", "s'<Esc>pa'")

vim.keymap.set('n', "''", "ciw'<Esc>p") -- Quotes the current word with single quotes
vim.keymap.set('n', '""', 'ciw"<Esc>p') -- Quotes the current word with double quotes
-- vim.keymap.set("n", "<leader>ss", "<cmd>source ~/.config/nvim/init.lua<CR>")
