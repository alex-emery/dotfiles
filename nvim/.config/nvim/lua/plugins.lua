return require('packer').startup(function()
  use  { 'wbthomason/packer.nvim' }

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/playground'
  use { 'neovim/nvim-lspconfig', config = function() 
    require 'plugins.nvim-lspconfig'
  end }

  -- Auto Completion
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'

  use { 'hrsh7th/nvim-cmp', config = function() 
	  require 'plugins.nvim-cmp'
  end }

  -- Debugger
  use { 'mfussenegger/nvim-dap', config = function()
      require 'plugins.nvim-dap'
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
  -- Color scheme
  use { 
        'marko-cerovac/material.nvim',
        config = function()
            require 'plugins.material-nvim'
        end
    }
-- file explorer and icons
-- " requires
 use 'kyazdani42/nvim-web-devicons' 
 use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() require'nvim-tree'.setup {} end
}

use {'rrethy/vim-hexokinase', run='make'}
use({
	"catppuccin/nvim",
	as = "catppuccin"
})

end)

-- https://github.com/tomaskallup/dotfiles/tree/master/nvim/lua/plugins
