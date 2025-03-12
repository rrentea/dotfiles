return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup {
        ensure_installed = { 'python', 'rust', 'bash', 'c', 'html', 'lua', 'markdown', 'vim', 'vimdoc' },
        -- Autoinstall languages that are not installed
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        textobjects = {
          select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              -- You can optionally set descriptions to the mappings (used in the desc parameter of
              -- nvim_buf_set_keymap) which plugins like which-key display
              ['ic'] = { query = '@class.inner', desc = 'Select inner part of a class region' },
              -- You can also use captures from other query groups like `locals.scm`
              ['as'] = { query = '@scope', query_group = 'locals', desc = 'Select language scope' },
            },
            -- You can choose the select mode (default is charwise 'v')
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * method: eg 'v' or 'o'
            -- and should return the mode ('v', 'V', or '<c-v>') or a table
            -- mapping query_strings to modes.
            selection_modes = {
              ['@parameter.outer'] = 'v', -- charwise
              ['@function.outer'] = 'V', -- linewise
              ['@class.outer'] = 'V', -- blockwise
            },
            -- If you set this to `true` (default is `false`) then any textobject is
            -- extended to include preceding or succeeding whitespace. Succeeding
            -- whitespace has priority in order to act similarly to eg the built-in
            -- `ap`.
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * selection_mode: eg 'v'
            -- and should return true or false
            include_surrounding_whitespace = false,
          },
          swap = {
            enable = true,
            swap_next = {
              ['<leader>sa'] = '@parameter.inner',
            },
            swap_previous = {
              ['<leader>sA'] = '@parameter.inner',
            },
          },
        },
      }

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see :help nvim-treesitter-incremental-selection-mod
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
  },

  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  --   main = "ibl",
  --   opts = {
  --     indent = {
  --       char = "▏",
  --       tab_char = "▏",
  --       smart_indent_cap = true,
  --     },
  --     whitespace = {
  --       remove_blankline_trail = false,
  --     },
  --     scope = {
  --       enabled = true,
  --       show_start = true,
  --       show_end = true,
  --       -- highlight = {
  --       --   "RainbowDelimiterRed",
  --       --   "RainbowDelimiterYellow",
  --       --   "RainbowDelimiterBlue",
  --       --   "RainbowDelimiterOrange",
  --       --   "RainbowDelimiterGreen",
  --       --   "RainbowDelimiterViolet",
  --       --   "RainbowDelimiterCyan",
  --       -- },
  --       include = {
  --         node_type = {
  --           lua = {
  --             "chunk",
  --             "do_statement",
  --             "while_statement",
  --             "repeat_statement",
  --             "if_statement",
  --             "for_statement",
  --             "function_declaration",
  --             "function_definition",
  --             "table_constructor",
  --             "assignment_statement",
  --           },
  --           typescript = {
  --             "statement_block",
  --             "function",
  --             "arrow_function",
  --             "function_declaration",
  --             "method_definition",
  --             "for_statement",
  --             "for_in_statement",
  --             "catch_clause",
  --             "object_pattern",
  --             "arguments",
  --             "switch_case",
  --             "switch_statement",
  --             "switch_default",
  --             "object",
  --             "object_type",
  --             "ternary_expression",
  --           },
  --         },
  --       },
  --     },
  --   },
  --   config = function(_, opts)
  --     local hooks = require("ibl.hooks")
  --     -- hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
  --     require("ibl").setup(opts)
  --     hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  --   end,
  --   init = function()
  --     vim.opt.list = true
  --   end,
  -- },
}
