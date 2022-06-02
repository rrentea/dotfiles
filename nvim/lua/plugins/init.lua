local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = vim.fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
end
vim.cmd [[packadd packer.nvim]]

require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    -- UI
    use {
        'goolord/alpha-nvim',
        config = require('plugins.configs.alpha'),
        requires = { 'kyazdani42/nvim-web-devicons' }
    }
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons',
        },
        config = require('plugins.configs.nvimtree')
    }

    -- ColorScheme
    use {
        'catppuccin/nvim',
        as = 'catppuccin',
        config = require('plugins.configs.catppuccin')
    }

    -- TreeSitter
    use {
        'nvim-treesitter/nvim-treesitter',
        requires = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            'nvim-treesitter/playground',
            'mfussenegger/nvim-ts-hint-textobject',
            'p00f/nvim-ts-rainbow'
        },
        run = ':TSUpdate',
        config = require('plugins.configs.treesitter')
    }

    -- LSP
    use {
        'williamboman/nvim-lsp-installer',
        'neovim/nvim-lspconfig',
    }

    use 'ryanoasis/vim-devicons'
    use({
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'kdheepak/lazygit.nvim',
            'nvim-telescope/telescope-media-files.nvim',
            'nvim-telescope/telescope-fzy-native.nvim'
        },
        config = require('plugins.configs.telescope'),
    })
    use 'nvim-lua/popup.nvim'

    -- Completion
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'saadparwaiz1/cmp_luasnip',
        },
        config = require('plugins.configs.cmp')
    }
    use {
        'tzachar/cmp-tabnine',
        run='./install.sh'
    }


    -- Snippets
    use { 'L3MON4D3/LuaSnip', config = require('plugins.configs.luasnip') }
    use 'rafamadriz/friendly-snippets'

    use { 'onsails/lspkind.nvim' }

    use { 'jiangmiao/auto-pairs', config = require('plugins.configs.autopairs')}

    --Diagnostics
    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = require('plugins.configs.trouble')
    }


    -- Comment
    use { 'numToStr/Comment.nvim', config = require('plugins.configs.comment')}


    -- Debugger
    use {
        'mfussenegger/nvim-dap',
        requires = {
            'nvim-telescope/telescope-dap.nvim',
            'theHamsta/nvim-dap-virtual-text',
            'rcarriga/nvim-dap-ui'
        },
        config = require('plugins.configs.dap')
    }

    -- Vscode like tasks
    use 'skywind3000/asynctasks.vim'
    use 'skywind3000/asyncrun.vim'

    -- Status line
    use { 'feline-nvim/feline.nvim', config = require('plugins.configs.feline')}
    use { 'lewis6991/gitsigns.nvim', config = require('plugins.configs.gitsigns')}

    -- Linter
    -- use { 'dense-analysis/ale', config = require('plugins.configs.ale') }

    -- Lark syntax
    use 'lark-parser/vim-lark-syntax'

    -- Markdown
    use({ 'iamcco/markdown-preview.nvim', run = 'cd app && npm install', setup = function() vim.g.mkdp_filetypes = { 'markdown' } end, ft = { 'markdown' }, })

    -- Find and Replace
    use {'nvim-pack/nvim-spectre', config = require('plugins.configs.spectre')}

    -- Terminal
    use { 'akinsho/toggleterm.nvim', config = require('plugins.configs.toggleterm') }


    use 'chrisbra/Colorizer'
    use 'preservim/vimux'
    use 'tpope/vim-surround'
    use 'Asheq/close-buffers.vim'

    use 'wesQ3/vim-windowswap'
end)
