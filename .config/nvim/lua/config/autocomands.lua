-- [[ Basic Autocommands ]]
--  See :help lua-guide-autocommands

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd(
  "User",
  {
    group = vim.api.nvim_create_augroup("buvvers_keymap", {clear = true}),
    pattern = "BuvversAttach",
    callback = function()
      vim.keymap.set(
        "n",
        "d",
        function()
          local current_buf_handle = require("buvvers").get_current_buf_handle()
          MiniBufremove.delete(current_buf_handle, false)
        end,
        {
          buffer = require("buvvers").get_buvvers_buf_handle(),
          nowait = true,
        }
      )
      vim.keymap.set(
        "n",
        "o",
        function()
          local current_buf_handle = require("buvvers").get_current_buf_handle()
          local previous_win_handle = vim.fn.win_getid(vim.fn.winnr("#"))
          -- https://github.com/nvim-neo-tree/neo-tree.nvim/blob/0b44040ec7b8472dfc504bbcec735419347797ad/lua/neo-tree/utils/init.lua#L643
          vim.api.nvim_win_set_buf(previous_win_handle, current_buf_handle)
          vim.api.nvim_set_current_win(previous_win_handle)
        end,
        {
          buffer = require("buvvers").get_buvvers_buf_handle(),
          nowait = true,
        }
      )
    end,
  })
