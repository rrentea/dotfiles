return{
  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VeryLazy', -- Sets the loading event to 'VeryLazy'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()

      -- Document existing key chains
      require('which-key').register {
        {
          { "", desc = "<leader>s_", hidden = true },
          { "", group = "[D]ocument" },
          { "", desc = "<leader>d_", hidden = true },
          { "", group = "[R]ename" },
          { "", desc = "<leader>r_", hidden = true },
          { "", desc = "<leader>c_", hidden = true },
          { "", desc = "<leader>w_", hidden = true },
          { "", group = "[C]ode" },
          { "", group = "[W]orkspace" },
          { "", group = "[S]earch" },
        }
      }
    end,
  }
}
