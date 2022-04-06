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

    -- Git
    use 'tpope/vim-fugitive'

    -- Linter
    use 'dense-analysis/ale'
end)
