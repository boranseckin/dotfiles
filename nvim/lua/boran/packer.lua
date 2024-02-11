vim.cmd [[packadd packer.nvim]];

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim';

  -- Native FZF support for Telescope
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' };

  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } },
  };

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  }

  use 'nvim-treesitter/nvim-treesitter-context';

  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'hrsh7th/cmp-cmdline'},
      {'hrsh7th/cmp-nvim-lsp'},

      -- Snippets
      {'L3MON4D3/LuaSnip'},
    }
  };

  use 'j-hui/fidget.nvim';

  use 'mfussenegger/nvim-dap';

  -- For rust-analyzer support
  use 'mrcjkb/rustaceanvim';
  -- For memory-view
  use 'vxpm/ferris.nvim';

  use 'tpope/vim-fugitive';

  use 'nvim-tree/nvim-web-devicons';

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true },
  };

  use "numToStr/Comment.nvim";

  use "lukas-reineke/indent-blankline.nvim";

  use "ahmedkhalf/project.nvim";

  use "zbirenbaum/copilot.lua";

  use "olimorris/onedarkpro.nvim";
end);
