vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  use 'nvim-treesitter/nvim-treesitter-context'

  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {
        'williamboman/mason.nvim',
        run = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      {'williamboman/mason-lspconfig.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'hrsh7th/cmp-nvim-lsp'},

      -- Snippets
      {'L3MON4D3/LuaSnip'},
    }
  }

  use 'mfussenegger/nvim-dap';
  use 'simrat39/rust-tools.nvim'

  use 'tpope/vim-fugitive';

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  }

  use "Pocco81/auto-save.nvim"

  use "numToStr/Comment.nvim"

  use "windwp/nvim-autopairs"

  use "Pocco81/true-zen.nvim"

  use "lukas-reineke/indent-blankline.nvim"

  use "github/copilot.vim"

  use "olimorris/onedarkpro.nvim"
end)
