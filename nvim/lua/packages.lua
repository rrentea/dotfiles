require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use {
        'goolord/alpha-nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = function ()
            require'alpha'.setup(require'alpha.themes.startify'.config)
        end
    }
    use({
      "catppuccin/nvim",
      as = "catppuccin"
    })

    -- IDE
    use ({ 
        'nvim-treesitter/nvim-treesitter',
        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = {"python", "lua", "c"},
                sync_install = false,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "gnn",
                        node_incremental = "grn",
                        scope_incremental = "grc",
                        node_decremental = "grm",
                    },
                },
                indentation = {
                    enable = true,
                }
            })
        end
    })
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'
    use 'preservim/nerdtree'
    use 'kien/ctrlp.vim'
    use 'ryanoasis/vim-devicons'
    use({
        "nvim-telescope/telescope.nvim",
        requires = { { "nvim-lua/plenary.nvim" }, { "kdheepak/lazygit.nvim" } },
        config = function()
            require("telescope").load_extension("lazygit")
        end,
    })
    use 'nvim-telescope/telescope-fzy-native.nvim'
    use { 'CRAG666/code_runner.nvim',
        requires = 'nvim-lua/plenary.nvim'
    }
    use {
        'ray-x/lsp_signature.nvim',
        config = function()
            require("lsp_signature").setup({
                bind = true, -- This is mandatory, otherwise border config won't get registered.
                handler_opts = {
                    border = "rounded"
                }
            })
        end
    }

    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'

    use {'SirVer/ultisnips',
        requires = {{'honza/vim-snippets', rtp = '.'}},
        config = function()      
            vim.g.UltiSnipsExpandTrigger = '<Plug>(ultisnips_expand)'      
            vim.g.UltiSnipsJumpForwardTrigger = '<Plug>(ultisnips_jump_forward)'
            vim.g.UltiSnipsJumpBackwardTrigger = '<Plug>(ultisnips_jump_backward)'
            vim.g.UltiSnipsListSnippets = '<c-x><c-s>'
            vim.g.UltiSnipsRemoveSelectModeMappings = 0
        end
    }
    use 'quangnguyen30192/cmp-nvim-ultisnips'

    use 'jiangmiao/auto-pairs'
    use {
        'numToStr/Comment.nvim', -- Commenting
        config = function()
            require('Comment').setup()
        end
    }

    -- Status line
    use 'feline-nvim/feline.nvim'
    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end
    }

    -- Linter
    use 'dense-analysis/ale'

    -- Debugger
    use {
        "puremourning/vimspector",
        cmd = { "VimspectorInstall", "VimspectorUpdate" },
        fn = { "vimspector#Launch()", "vimspector#ToggleBreakpoint", "vimspector#Continue" },
        config = function()
            require("vimspector").setup()
        end,
    }

    -- Lark syntax
    use 'lark-parser/vim-lark-syntax'

    -- Window movement
    use 'sindrets/winshift.nvim'

    -- Transparent Background
    use {
        'xiyaowong/nvim-transparent',
        config = function()
            require("transparent").setup({
                enable = true, -- boolean: enable transparent
                extra_groups = { -- table/string: additional groups that should be cleared
                    -- In particular, when you set it to 'all', that means all available groups

                    -- example of akinsho/nvim-bufferline.lua
                    "BufferLineTabClose",
                    "BufferlineBufferSelected",
                    "BufferLineFill",
                    "BufferLineBackground",
                    "BufferLineSeparator",
                    "BufferLineIndicatorSelected",
                },
                exclude = {}, -- table: groups you don't want to clear
            })
        end
    }
end)
