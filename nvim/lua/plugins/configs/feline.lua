local ok, feline = pcall(require, "feline")

if not ok then
    return
end

vim.cmd [[ let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum" ]]
vim.cmd [[ let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum" ]]
vim.cmd [[ set termguicolors ]]

feline.setup({
    components = require('catppuccin.core.integrations.feline'),
})
