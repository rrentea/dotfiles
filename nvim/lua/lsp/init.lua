local utils = require('utils')

local servers = {
    'bashls',
    'clangd',
    'html',
    'jsonls',
    'pyright',
    'sumneko_lua',
    'tailwindcss',
    'texlab',
}

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or { { " ", "FloatBorder" } }
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local diagnostics_active = true
vim.keymap.set('n', '<leader>dt', function()
    diagnostics_active = not diagnostics_active
    if diagnostics_active then
        vim.diagnostic.show()
    else
        vim.diagnostic.hide()
    end
end)

-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
--
-- local lsp_formatting = function(bufnr)
--     vim.lsp.buf.format {
--         bufnr = bufnr,
--         filter = function(clients)
--             return vim.tbl_filter(function(client)
--                 if client.name == "eslint" then
--                     return true
--                 end
--                 if client.name == "null-ls" then
--                     return not utils.table.some(clients, function(_, other_client)
--                         return other_client.name == "eslint"
--                     end)
--                 end
--             end, clients)
--         end,
--     }
-- end

local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = 0 })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = 0 })
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = 0 })
    -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = 0 })
    vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<CR>', { buffer = 0 })
    vim.keymap.set('n', 'gl', '<cmd>Telescope diagnostics<CR>', { buffer = 0 })
    vim.keymap.set('n', 'F', function() vim.lsp.buf.format { async = true } end, { buffer = 0 })
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, { buffer = 0 })
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = 0 })
    -- vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = 0 })
    vim.keymap.set('n', '<leader>n', vim.diagnostic.goto_next, { buffer = 0 })
    vim.keymap.set('n', '<leader>p', vim.diagnostic.goto_prev, { buffer = 0 })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local had_cmp_nvim_lsp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if had_cmp_nvim_lsp then
    capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
end

local had_lspconfig = pcall(require, "lspconfig")
if had_lspconfig then
    for _, server in ipairs(servers) do
        require("lsp.servers." .. server).setup(on_attach, capabilities)
    end
end

-- Gutter sign icons
for type, icon in pairs(utils.signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Prefix diagnostic virtual text
vim.diagnostic.config {
    virtual_text = {
        source = "always",
        prefix = " ",
        spacing = 6,
    },
    float = {
        header = false,
        source = "always",
    },
    signs = true,
    underline = true,
    update_in_insert = false,
}
