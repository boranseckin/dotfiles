vim.pack.add({
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-telescope/telescope.nvim',
})

require('telescope').setup({
  pickers = {
    find_files = { theme = "ivy" },
    git_files  = { theme = "ivy" },
    buffers = {
      mappings = { i = { ["<C-d>"] = "delete_buffer" } },
    },
  },
})

local t = require('telescope.builtin')
vim.keymap.set("n", "<leader>ff", t.find_files,            { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", t.live_grep,             { desc = "Live grep" })
vim.keymap.set("n", "<leader>fa", t.lsp_workspace_symbols, { desc = "Workspace symbols" })
vim.keymap.set("n", "<leader>fs", t.lsp_document_symbols,  { desc = "Document symbols" })
vim.keymap.set("n", "<leader>fb", t.buffers,               { desc = "Buffers" })
vim.keymap.set("n", "<leader>gf", t.git_files,             { desc = "Git files" })
vim.keymap.set("n", "<leader>gc", t.git_commits,           { desc = "Git commits" })
vim.keymap.set("n", "<leader>gb", t.git_bcommits,          { desc = "Buffer git commits" })
vim.keymap.set("n", "<leader>gs", t.git_status,            { desc = "Git status" })
vim.keymap.set("n", "<leader>gr", t.git_branches,          { desc = "Git branches" })
