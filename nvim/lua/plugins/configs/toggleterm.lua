local ok, toggleterm = pcall(require, "toggleterm")

if not ok then
    return
end

toggleterm.setup({
    size = function (term)
        if term.direction == "horizontal" then
            return 15
        elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
        end
    end,
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_filetype = {},
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = 'tab',
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
            border = "Normal",
            background = "Normal"
        }
    }
})

function _G.set_terminal_keymaps()
    -- local opts = { noremap = true }
    -- vim.keymap.set('t', '<esc>', '<c-\\><c-n>', opts)
    -- vim.keymap.set('t', 'jk', '<c-\\><c-n>', opts)
    -- vim.keymap.set('t', '<a-h>', '<c-\\><c-n><c-w>h', opts)
    -- vim.keymap.set('t', '<a-j>', '<c-\\><c-n><c-w>j', opts)
    -- vim.keymap.set('t', '<a-k>', '<c-\\><c-n><c-w>k', opts)
    -- vim.keymap.set('t', '<a-l>', '<c-\\><c-n><c-w>l', opts)
end

vim.api.nvim_create_autocmd('TermOpen', {
    pattern = "term://*toggleterm#*",
    callback = function ()
        set_terminal_keymaps()
    end
})

