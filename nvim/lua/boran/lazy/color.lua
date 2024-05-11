return {
  {
    "olimorris/onedarkpro.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      options = {
        transparency = true,
      }
    },
    config = function()
      vim.cmd.colorscheme("onedark");
    end,
  },
}
