return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    enabled = false,
    config = function ()
      local harpoon = require("harpoon")

      -- REQUIRED
      harpoon:setup()
      -- REQUIRED

      vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "[H]arpoon [A]dd buffer to list"})
      vim.keymap.set("n", "<leader>he", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "[H]arpoon [E]dit list"})

      vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
      vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end)
      vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3) end)
      vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end)

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
      vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
    end
  },
  {
    "aidancz/buvvers.nvim",
    config = function ()
      require("buvvers").setup({
        name_prefix = function(buffer_handle)
          local icon, hl = MiniIcons.get("file", vim.api.nvim_buf_get_name(buffer_handle))
          return {
            icon .. " ",
            hl,
          }
        end,
      })
      -- require("buvvers").open()
      vim.keymap.set("n", "<leader>b", require("buvvers").toggle)

      vim.keymap.set('n', '<C-j>', ":bnext<CR>", { desc = 'Move to next buffer' })
      vim.keymap.set('n', '<C-k>', ":bprev<CR>", { desc = 'Move to prev buffer' })

    end
  }
}
