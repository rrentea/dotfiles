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
        requires = { 'kyazdani42/nvim-web-devicons' }
    }
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons',
        }
    }

    -- ColorScheme
    use {
        'catppuccin/nvim',
        as = 'catppuccin',
        run = ':CatppuccinCompile'
    }

    use {'fladson/vim-kitty'}

    -- TreeSitter
    use {
        'nvim-treesitter/nvim-treesitter',
        requires = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            'nvim-treesitter/playground',
            'mfussenegger/nvim-ts-hint-textobject',
            'p00f/nvim-ts-rainbow',
            'ziontee113/syntax-tree-surfer'
        },
        run = ':TSUpdate'
    }

    -- LSP
    use {
        'williamboman/nvim-lsp-installer',
        'neovim/nvim-lspconfig',
    }
    use {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function()
            require("lsp_lines").setup()
        end,
    }

    use 'ryanoasis/vim-devicons'
    use({
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'kdheepak/lazygit.nvim',
            'nvim-telescope/telescope-media-files.nvim',
            'nvim-telescope/telescope-fzy-native.nvim'
        }
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
        }
    }
    -- use {
    --     'tzachar/cmp-tabnine',
    --     run='./install.sh'
    -- }

    -- Snippets
    use { 'L3MON4D3/LuaSnip' }
    use 'rafamadriz/friendly-snippets'

    use { 'onsails/lspkind.nvim' }

    use { 'windwp/nvim-autopairs'}

    --Diagnostics
    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons"
    }


    -- Comment
    use { 'numToStr/Comment.nvim'}


    -- Debugger
    use {
        'mfussenegger/nvim-dap',
        requires = {
            'nvim-telescope/telescope-dap.nvim',
            'theHamsta/nvim-dap-virtual-text',
            'rcarriga/nvim-dap-ui'
        },
    }

    -- Vscode like tasks
    use 'skywind3000/asynctasks.vim'
    use 'skywind3000/asyncrun.vim'

    -- Status line
    use { 'feline-nvim/feline.nvim'}
    use { 'lewis6991/gitsigns.nvim'}

    -- Linter
    -- use { 'dense-analysis/ale', config = require('plugins.configs.ale') }

    -- Lark syntax
    -- use 'lark-parser/vim-lark-syntax'

    -- Markdown
    use({ 'iamcco/markdown-preview.nvim', run = 'cd app && npm install', setup = function() vim.g.mkdp_filetypes = { 'markdown' } end, ft = { 'markdown' }, })

    -- Find and Replace
    use {'nvim-pack/nvim-spectre'}

    -- use({
    --     'ray-x/navigator.lua',
    --     requires = {
    --         { 'ray-x/guihua.lua', run = 'cd lua/fzy && make' },
    --         { 'neovim/nvim-lspconfig' },
    --     },
    --     config = require('plugins.configs.navigator')
    -- })

    -- Terminal
    use { 'akinsho/toggleterm.nvim'}

    use 'chrisbra/Colorizer'
    -- use 'preservim/vimux'
    use 'tpope/vim-surround'
    -- use 'Asheq/close-buffers.vim'

    use 'wesQ3/vim-windowswap'
    use 'dstein64/vim-startuptime'
    use {'karb94/neoscroll.nvim'}

    use ({
        'weilbith/nvim-code-action-menu',
        opt = false,
        cmd = 'CodeActionMenu',
    })

    use {'lewis6991/impatient.nvim'}
    use {'Vimjas/vim-python-pep8-indent'}
    use {'norcalli/nvim-colorizer.lua', config = require('colorizer').setup()}
    use {
        'wiliamks/nice-reference.nvim',
        requires = {
            'kyazdani42/nvim-web-devicons', --optional
            { 'rmagatti/goto-preview', config = require('goto-preview').setup({references = {}})}, --optional
        }
    }
end)

require('plugins.configs.alpha')
require('plugins.configs.ale')
require('plugins.configs.autopairs')
require('plugins.configs.catppuccin')
require('plugins.configs.treesitter')
require('plugins.configs.telescope')
require('plugins.configs.cmp')
require('plugins.configs.luasnip')
require('plugins.configs.trouble')
require('plugins.configs.comment')
require('plugins.configs.feline')
require('plugins.configs.gitsigns')
require('plugins.configs.spectre')
require('plugins.configs.toggleterm')
require('plugins.configs.neoscroll')
require('plugins.configs.nvimtree')
require('plugins.configs.nice-reference')
