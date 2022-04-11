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
    use 'nvim-treesitter/nvim-treesitter'
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'
    use 'preservim/nerdtree'
    use 'kien/ctrlp.vim'
    use 'ryanoasis/vim-devicons'
    -- use {
    --     'nvim-telescope/telescope.nvim',
    --     requires = { {'nvim-lua/plenary.nvim'} }
    -- }
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

    -- Autocomplete
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'
    use 'windwp/nvim-autopairs'
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
        -- cmd = { "VimspectorInstall", "VimspectorUpdate" },
        -- fn = { "vimspector#Launch()", "vimspector#ToggleBreakpoint", "vimspector#Continue" },
        config = function()
            require("vimspector").setup()
        end,
    }

    -- Lark syntax
    use 'lark-parser/vim-lark-syntax'
end)
