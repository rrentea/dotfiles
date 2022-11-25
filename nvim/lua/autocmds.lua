-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
})

-- Toggle relative line numbers in normal mode and absolute line numbers in insert mode
vim.api.nvim_create_autocmd("InsertEnter", {
    pattern = "*",
    callback = function()
        vim.cmd(":set norelativenumber")
        vim.lsp.buf.clear_references()
    end
})
vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = "*",
    callback = function()
        vim.cmd(":set relativenumber")
    end
})

-- Setting the color column only for python files
vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
        vim.api.nvim_command("set cc=88")
    end
})

vim.api.nvim_create_autocmd("BufLeave", {
    pattern = "*launch.json",
    callback = function()
        vim.api.nvim_command("w!")
    end
})

-- Disable line numbers in terminal mode
vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    callback = function ()
        vim.api.nvim_command("setlocal nonumber norelativenumber")
    end
})

-- Start terminal mode when terminal buffer open.
vim.api.nvim_create_autocmd("TermOpen", {
    callback = function ()
        vim.api.nvim_command("startinsert!")
    end
})

-- Highlight the hover word
vim.api.nvim_create_autocmd("CursorHold", {
    pattern = "*",
    callback = function ()
        if not vim.bo.filetype == "json" then
            vim.lsp.buf.document_highlight()
        end
    end
})

-- Clear highlighting
vim.api.nvim_create_autocmd("CursorMoved", {
    pattern = "*",
    callback = function ()
        if not vim.bo.filetype == "json" then
            vim.lsp.buf.clear_references()
        end
    end
})
