vim.pack.add({ 'https://github.com/olimorris/onedarkpro.nvim' })

require("onedarkpro").setup({ options = { transparency = true } })

vim.cmd.colorscheme("onedark")
