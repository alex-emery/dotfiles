return require('packer').startup(function()
    use  { 'wbthomason/packer.nvim' }

    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'nvim-treesitter/playground'
    use { 'nvim-treesitter/nvim-treesitter-context', config = function()
        require 'treesitter-context'.setup{}
    end }

    -- LSP and Friends
    use { 'neovim/nvim-lspconfig', config = function()
        require 'plugins.nvim-lspconfig'
    end }
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'

    use { 'hrsh7th/nvim-cmp', config = function()
        require 'plugins.nvim-cmp'
    end }

    use {'mfussenegger/nvim-lint', config = function()
        require('lint').linters_by_ft = {
            golang = {'golangcilint',}
        }
    end}
    -- Debugger
    use { 'mfussenegger/nvim-dap', config = function()
        require 'plugins.nvim-dap'
    end }

    use { 'leoluz/nvim-dap-go', config = function()
        require('dap-go').setup()
    end }
    use { "theHamsta/nvim-dap-virtual-text", config = function()
        require 'plugins.nvim-dap-virtual-text'
    end }
    use { "rcarriga/nvim-dap-ui", config = function()
        require 'plugins.nvim-dap-ui'
    end }

    -- fzf
    use {'junegunn/fzf', run = 'fzf#install()' }
    use 'junegunn/fzf.vim'
    -- terescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
        config = function() require 'plugins.telescope' end
    }
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use {'nvim-telescope/telescope-dap.nvim' }

    -- Vim dispatch
    use { 'tpope/vim-dispatch' }
    -- Fugitive for Git
    use { 'tpope/vim-fugitive' }
    -- Seamless tmux navigation
    use 'christoomey/vim-tmux-navigator'

    -- file explorer and icons
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icon
        },
        config = function() require'nvim-tree'.setup {} end,
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }

    -- use {'rrethy/vim-hexokinase', run='make'}

    -- themes
    -- use 'folke/tokyonight.nvim'

end)

-- https://github.com/tomaskallup/dotfiles/tree/master/nvim/lua/plugins
