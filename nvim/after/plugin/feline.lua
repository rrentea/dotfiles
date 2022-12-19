local ok, feline = pcall(require, "feline")

if not ok then
    return
end

vim.cmd [[ let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum" ]]
vim.cmd [[ let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum" ]]
vim.cmd [[ set termguicolors ]]

local ctp_feline = require('catppuccin.groups.integrations.feline')
ctp_feline.setup({})

feline.setup({
    components = ctp_feline.get(),
})
