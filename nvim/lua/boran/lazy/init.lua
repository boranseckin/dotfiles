return {
  "tpope/vim-fugitive",

  {
    "j-hui/fidget.nvim",
    opts = {
      progress = { display = { done_ttl = 5, }, },
      notification = { window = { winblend = 0, }, },
    },
  },

  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = {}
  },
}
