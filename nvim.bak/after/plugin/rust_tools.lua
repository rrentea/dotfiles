local ok, rt = pcall(require, "rust-tools")

if not ok then
    return
end

local extension_path = vim.env.HOME .. '/bin/extension/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'

rt.setup({
    tools = {
        inlay_hints = {
            auto = false,
        },
        hover_actions = {
            auto_focus = true,
        },
    },
    server = {
        on_attach = function(client, bufnr)
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
            nmap('<leader>sd', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
            nmap('<leader>sw', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

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
            -- Hover actions
            vim.keymap.set("n", "<leader>rk", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<Leader>ra", rt.code_action_group.code_action_group, { buffer = bufnr })
            nmap("<leader>rhe", rt.inlay_hints.enable, "[R]ust inlay [H]ints [E]nable");
            nmap("<leader>rhd", rt.inlay_hints.disable, "[R]ust inlay [H]ints [D]nable");

            -- Create a command `:Format` local to the LSP buffer
            vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
                if vim.lsp.buf.format then
                    vim.lsp.buf.format()
                elseif vim.lsp.buf.formatting then
                    vim.lsp.buf.formatting()
                end
            end, { desc = 'Format current buffer with LSP' })

            if client.server_capabilities.documentHighlightProvider then
                local group = vim.api.nvim_create_augroup("LSPDocumentHighlight", {})

                vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                    buffer = bufnr,
                    group = group,
                    callback = function()
                        vim.lsp.buf.document_highlight()
                    end,
                })
                vim.api.nvim_create_autocmd({ "CursorMoved" }, {
                    buffer = bufnr,
                    group = group,
                    callback = function()
                        vim.lsp.buf.clear_references()
                    end,
                })
            end
        end
    },
    dap = {
        adapter = require('rust-tools.dap').get_codelldb_adapter(
            codelldb_path, liblldb_path)
    }
})
