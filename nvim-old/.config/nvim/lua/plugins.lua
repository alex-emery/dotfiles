return require('packer').startup(function()
    use { 'wbthomason/packer.nvim' }

    -- Tree sitter and Friends
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'nvim-treesitter/playground'
    use { 'nvim-treesitter/nvim-treesitter-context', config = function()
        require 'treesitter-context'.setup {}
    end }

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    use { "lukas-reineke/indent-blankline.nvim", config = function()
        vim.opt.list = true
        vim.opt.listchars:append "space:⋅"
        vim.opt.listchars:append "eol:↴"
        require("indent_blankline").setup {
            space_char_blankline = " ",
            show_current_context = true,
            show_current_context_start = true,
        }
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

    use { 'mfussenegger/nvim-lint', config = function()
        require('lint').linters_by_ft = {
            golang = { 'golangcilint', }
        }
        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
            callback = function()
                require("lint").try_lint()
            end,
        })
        vim.api.nvim_create_autocmd({ "InsertLeave" }, {
            callback = function()
                require("lint").try_lint()
            end,
        })
    end }
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
    use { 'junegunn/fzf', run = 'fzf#install()' }
    use 'junegunn/fzf.vim'
    -- terescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            { 'nvim-lua/popup.nvim' },
            { 'nvim-lua/plenary.nvim' },
            { "nvim-telescope/telescope-live-grep-args.nvim" },
        },
        config = function() require 'plugins.telescope' end
    }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use { 'nvim-telescope/telescope-dap.nvim' }

    -- Git stuff
    use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim', config = function()
        require('neogit').setup {}
    end }

    -- Seamless tmux navigation
    use 'christoomey/vim-tmux-navigator'

    -- file explorer and icons
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icon
        },
        config = function() require 'nvim-tree'.setup {} end,
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }

    use {
        'nvim-lualine/lualine.nvim',
        config = function() 
            require('lualine').setup()
    end }
    -- themes
    use { 'ray-x/aurora', config = function()

    end }
end)

-- https://github.com/tomaskallup/dotfiles/tree/master/nvim/lua/plugins