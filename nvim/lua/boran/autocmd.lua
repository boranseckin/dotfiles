vim.api.nvim_create_autocmd("ModeChanged", { pattern = "*:n*", command = "set number norelativenumber" })
vim.api.nvim_create_autocmd("ModeChanged", { pattern = "n*:*", command = "set nonumber relativenumber" })
