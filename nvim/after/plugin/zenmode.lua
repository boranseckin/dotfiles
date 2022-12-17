require("zen-mode").setup {
  window = {
    options = {
      number = true,
      relativenumber = true,
    }
  },
}

vim.keymap.set("n", "<leader>zz", function()
  require("zen-mode").toggle()
  vim.wo.wrap = false
  FixColors()
end)

