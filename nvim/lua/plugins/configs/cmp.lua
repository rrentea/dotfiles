local ok, cmp = pcall(require, 'cmp')

if not ok then
    return
end

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    completion = {
        completeopt = 'menu,menuone,noinsert' -- Auto highlight the first row
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(nil),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<c-k>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'luasnip' },
        { name = 'cmp_tabnine' },
    }, {
        { name = 'buffer' },
    }),

    formatting = {
        format = require('lspkind').cmp_format {
            with_text = true,
            menu = {
                buffer = "[buf]",
                nvim_lsp = "[LSP]",
                nvim_lua = "[api]",
                cmp_tabnine = "[tabnine]",
                luasnip = "[snip]"
            }
        }
    }
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
        { name = 'buffer' },
    })
})

-- -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline('/', {
--     mapping = cmp.mapping.preset.cmdline(),
--     sources = {
--         { name = 'buffer' }
--     }
-- })
--
-- -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline(':', {
--     -- mapping = cmp.mapping.preset.insert({
--     --     ['<C-Space>'] = cmp.mapping.complete(),
--     --     ['<C-e>'] = cmp.mapping.abort(),
--     --     ['<c-k>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
--     -- }),
--     mapping = cmp.mapping.preset.cmdline(),
--     completion = {
--         completeopt = 'menu,menuone,noinsert' -- Auto highlight the first row
--     },
--     sources = cmp.config.sources({
--         { name = 'path' }
--     }, {
--         { name = 'cmdline' }
--     })
-- })

-- Setup lspconfig.
-- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
-- require('lspconfig')['pyright'].setup {
--     capabilities = capabilities
-- }
-- require('lspconfig')['sumneko_lua'].setup {
--     capabilities = capabilities
-- }
-- require('lspconfig')['ccls'].setup {
--     capabilities = capabilities
-- }
