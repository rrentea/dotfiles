local lsp = require('lsp-zero')

lsp.preset("recommended")


-- local lsp_installer = require('nvim-lsp-installer')
-- lsp_installer.on_server_ready(function (server)
--     server:setup {}
-- end)

lsp.ensure_installed({
    'bashls',
    'clangd',
    'html',
    'jsonls',
    'pyright',
    'sumneko_lua',
    'tailwindcss',
    'texlab',
    'rust_analyzer',
    'taplo'
})

lsp.configure('sumneko_lua', {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = {
                    "vim",
                    "use",
                    "describe",
                    "it",
                    "assert",
                    "before_each",
                    "after_each",
                    "awesome"
                },
            },
            disable = {
                "lowercase-global",
                "undefined-global",
                "unused-local",
                "unused-function",
                "unused-vararg",
                "trailing-space",
            },
        },
    }
})

-- local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
-- function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
--     opts = opts or {}
--     opts.border = opts.border or { { " ", "FloatBorder" } }
--     return orig_util_open_floating_preview(contents, syntax, opts, ...)
-- end

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-k>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = '',
        warn = '',
        hint = '',
        info = ''
    }
})

local line_diagnostics_active = false
vim.keymap.set('n', '<leader>dt', function()
    line_diagnostics_active = not line_diagnostics_active
    if line_diagnostics_active then
        vim.diagnostic.config {
            virtual_text = false,
            virtual_lines = true
        }
    else
        vim.diagnostic.config {
            virtual_text = true,
            virtual_lines = false
        }
    end
end)


lsp.on_attach(function(client, bufnr)
    if client.name == "eslint" then
        vim.cmd.LspStop('eslint')
        return
    end

    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end


    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        if vim.lsp.buf.format then
            vim.lsp.buf.format()
        elseif vim.lsp.buf.formatting then
            vim.lsp.buf.formatting()
        end
    end, { desc = 'Format current buffer with LSP' })
end)
--
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- local had_cmp_nvim_lsp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
-- if had_cmp_nvim_lsp then
--     capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
-- end

-- local had_lspconfig = pcall(require, "lspconfig")
-- if had_lspconfig then
--     for _, server in ipairs(servers) do
--         require("lsp.servers." .. server).setup(on_attach, capabilities)
--     end
-- end

lsp.setup()

-- Prefix diagnostic virtual text
vim.diagnostic.config {
    -- virtual_text = {
    --     source = "always",
    --     prefix = " ",
    --     spacing = 6,
    -- },
    -- float = {
    --     header = false,
    --     source = "always",
    -- },
    -- signs = true,
    -- underline = true,
    -- update_in_insert = false,
    virtual_text = true,
    virtual_lines = false
}

local ok, lsp_lines = pcall(require, "lsp_lines")

if not ok then
    return
end

lsp_lines.setup()
