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
    -- use 'preservim/nerdtree'
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons',
        }
    }
    use 'ryanoasis/vim-devicons'
    use({
        "nvim-telescope/telescope.nvim",
        requires = { { "nvim-lua/plenary.nvim" }, { "kdheepak/lazygit.nvim" } },
        config = function()
            require("telescope").load_extension("lazygit")
            require("telescope").load_extension("dap")
        end,
    })
    use 'nvim-lua/popup.nvim'
    use 'nvim-telescope/telescope-fzy-native.nvim'
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
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use { 'onsails/lspkind.nvim' }

    use "saadparwaiz1/cmp_luasnip"
    use 'L3MON4D3/LuaSnip'
    use 'rafamadriz/friendly-snippets'

    use 'jiangmiao/auto-pairs'
    use {
        'numToStr/Comment.nvim', -- Commenting
        config = function()
            require('Comment').setup()
        end
    }
    -- Debugger
    use 'mfussenegger/nvim-dap'
    use 'nvim-telescope/telescope-dap.nvim'
    use 'theHamsta/nvim-dap-virtual-text'
    use 'rcarriga/nvim-dap-ui'

    -- Vscode like tasks
    use 'skywind3000/asynctasks.vim'
    use 'skywind3000/asyncrun.vim'

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

    -- Lark syntax
    use 'lark-parser/vim-lark-syntax'

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
    use 'preservim/vimux'
end)
