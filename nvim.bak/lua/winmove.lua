local M = {}

function M.winmove(key)
    local curwin = vim.fn.winnr()
    vim.api.nvim_exec("wincmd " .. key, true)
    if curwin == vim.fn.winnr() then
        if key == 'j' or key == 'k'then
            vim.api.nvim_exec("wincmd s", true)
        else
            vim.api.nvim_exec("wincmd v", true)
        end
        vim.api.nvim_exec("wincmd " .. key, true)
    end
end

return M
