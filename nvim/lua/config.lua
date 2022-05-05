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


-- LSP Config
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    print("hello")
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = 0 })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = 0 })
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = 0 })
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = 0 })
    vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<CR>', { buffer = 0 })
    vim.keymap.set('n', 'gl', '<cmd>Telescope diagnostics<CR>', { buffer = 0 })
    vim.keymap.set('n', 'F', function() vim.lsp.buf.format { async = true } end, { buffer = 0 })
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, { buffer = 0 })
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = 0 })
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = 0 })
    vim.keymap.set('n', '<leader>n', vim.diagnostic.goto_next, { buffer = 0 })
    vim.keymap.set('n', '<leader>p', vim.diagnostic.goto_prev, { buffer = 0 })
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
require('lspconfig').pyright.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}
require('lspconfig').clangd.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

local sumneko_binary_path = vim.fn.exepath('lua-language-server')
local sumneko_root_path = vim.fn.fnamemodify(sumneko_binary_path, ':h:h')

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require 'lspconfig'.sumneko_lua.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = { sumneko_binary_path, "-E", sumneko_root_path .. "/main.lua" };
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = runtime_path,
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim', 'use' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}



-- require('nvim-lsp-setup').setup({
--     default_mappings = false,
--     -- Example mappings for telescope pickers:
--     -- gd = 'lua require"telescope.builtin".lsp_definitions()',
--     -- gi = 'lua require"telescope.builtin".lsp_implementations()',
--     -- gr = 'lua require"telescope.builtin".lsp_references()',
--     mappings = {
--         gD = 'lua vim.lsp.buf.declaration()',
--         gd = 'lua vim.lsp.buf.definition()',
--         gt = 'lua vim.lsp.buf.type_definition()',
--         gi = 'lua vim.lsp.buf.implementation()',
--         gr = 'lua vim.lsp.buf.references()',
--         -- K = 'lua vim.lsp.buf.hover()',
--         -- ['<C-k>'] = 'lua vim.lsp.buf.signature_help()',
--         ['<C-k>'] = 'lua vim.lsp.buf.hover()',
--         ['<space>rn'] = 'lua vim.lsp.buf.rename()',
--         ['<space>ca'] = 'lua vim.lsp.buf.code_action()',
--         ['<space>f'] = 'lua vim.lsp.buf.formatting()',
--         ['<space>e'] = 'lua vim.lsp.diagnostic.show_line_diagnostics()',
--         ['[d'] = 'lua vim.lsp.diagnostic.goto_prev()',
--         [']d'] = 'lua vim.lsp.diagnostic.goto_next()',
--     },
--     -- Global on_attach
--     -- on_attach = function(client, bufnr)
--     --     require('nvim-lsp-setup.utils').format_on_save(client)
--     -- end,
--     -- Global capabilities
--     -- capabilities = vim.lsp.protocol.make_client_capabilities(),
--     -- LSP servers
--     servers = {
--         -- Install LSP servers automatically
--         -- LSP server configuration please see: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
--         pyright = {},
--         sumneko_lua = {
--             settings = {
--                 Lua = {
--                     diagnostics = {
--                         globals = { 'vim', 'use' },
--                     },
--                 }
--             }
--         },
--         ccls = {},
--     },
-- })
-- local saga = require('lspsaga')
-- use_saga_diagnostic_sign = true
-- error_sign = '',
-- warn_sign = '',
-- hint_sign = '',
-- infor_sign = '',
-- dianostic_header_icon = '   ',
-- code_action_icon = ' ',
-- code_action_prompt = {
--   enable = true,
--   sign = true,
--   sign_priority = 20,
--   virtual_text = true,
-- },
-- finder_definition_icon = '  ',
-- finder_reference_icon = '  ',
-- max_preview_lines = 10, -- preview lines of lsp_finder and definition preview
-- finder_action_keys = {
--   open = 'o', vsplit = 's',split = 'i',quit = 'q',scroll_down = '<C-f>', scroll_up = '<C-b>' -- quit can be a table
-- },
-- code_action_keys = {
--   quit = 'q',exec = '<CR>'
-- },
-- rename_action_keys = {
--   quit = '<C-c>',exec = '<CR>'  -- quit can be a table
-- },
-- definition_preview_icon = '  '
-- "single" "double" "round" "plus"
-- border_style = "single"
-- rename_prompt_prefix = '➤',
-- if you don't use nvim-lspconfig you must pass your server name and
-- the related filetypes into this table
-- like server_filetype_map = {metals = {'sbt', 'scala'}}
-- server_filetype_map = {}('lspsaga')
-- saga.init_lsp_saga()


-- Telescope
-- require('telescope').setup({
--     file_ingore_patterns = {".*/env/.*", ".*/venv/.*"}
-- })

-- Debug Config
local dap = require('dap')
local dapui = require('dapui')

dap.adapters.python = {
    type = 'executable';
    command = 'python';
    args = { '-m', 'debugpy.adapter' };
}

dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = '/home/rrentea/bin/extension/debugAdapters/bin/OpenDebugAD7',
  -- command = 'gdb',
  options = {
    detached = false
  }
}
dap.configurations.cpp = {
    {
        name = "Launch file",
        type = "cppdbg",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = true,
    }
}
dap.configurations.python = {
    -- {
    --   type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
    --   request = 'launch';
    -- },
}

vim.fn.sign_define('DapBreakpoint', { text = '🟥', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointRejected', { text = '🟦', texthl = '', linehl = '', numhl = '' })

require("nvim-dap-virtual-text").setup {
    enabled = true, -- enable this plugin (the default)
    enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
    highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
    highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
    show_stop_reason = true, -- show stop reason when stopped for exceptions
    commented = false, -- prefix virtual text with comment string
    -- experimental features:
    virt_text_pos = 'eol', -- position of virtual text, see `:h nvim_buf_set_extmark()`
    all_frames = true, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
    virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
    virt_text_win_col = 80 -- position the virtual text at a fixed window column (starting from the first text column) ,
    -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
}

dapui.setup()
vim.api.nvim_create_autocmd("BufLeave", {
    pattern = "*launch.json",
    callback = function()
        vim.api.nvim_command('w!')
    end
})

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end


-- Feline
vim.cmd [[let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"]]
vim.cmd [[let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"]]
vim.cmd [[ set termguicolors ]]

require("feline").setup({
    components = require('catppuccin.core.integrations.feline'),
})


-- ALE config
vim.g.ale_python_pylint_executable = 'flake8'
vim.g.ale_python_pyling_use_global = 1
vim.g.ale_virtualenv_dir_names = {'env', 'venv'}

vim.g.ale_fixers = {
    python = {'yapf'},
    cpp = {'clang-format'}
}


-- Color Scheme
vim.cmd [[ colorscheme catppuccin ]]

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
vim.opt.wildmode = { "list", "full" }
vim.opt.shell = vim.env.SHELL
vim.opt.cmdheight = 1 -- command bar height
vim.opt.title = true -- set terminal title
vim.opt.showmatch = true -- show matching braces
vim.opt.mat = 2 -- how many tenths of a second to blink
vim.opt.updatetime = 300
vim.opt.signcolumn = "yes"
vim.opt.shortmess = "atToOFc" -- prompt message options
vim.opt.laststatus = 3 -- Global status line
vim.opt.autowriteall = true
vim.opt.colorcolumn = "0"

vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
        vim.api.nvim_command('set cc=80')
    end
})

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
-- vim.lsp.handlers['textDocument/publishDiagnostics'] = function() end

vim.g.asyncrun_open = 6
vim.g.asynctasks_term_pos = 'bottom'
vim.g.asynctasks_term_rows = 10 -- set height for the horizontal terminal split
vim.g.asynctasks_term_cols = 80 -- set width for vertical terminal split

vim.g.windowswap_map_keys = 0
