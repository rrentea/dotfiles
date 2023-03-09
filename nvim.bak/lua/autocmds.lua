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
-- vim.api.nvim_create_autocmd("InsertEnter", {
--     pattern = "*",
--     callback = function()
--         vim.cmd(":set norelativenumber")
--         vim.lsp.buf.clear_references()
--     end
-- })
-- vim.api.nvim_create_autocmd("InsertLeave", {
--     pattern = "*",
--     callback = function()
--         vim.cmd(":set relativenumber")
--     end
-- })

-- Setting the color column
vim.api.nvim_create_autocmd("FileType", {
    pattern = {"python", "rust"},
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

-- Remember the last save location
vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
