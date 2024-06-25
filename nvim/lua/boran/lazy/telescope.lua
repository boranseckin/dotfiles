return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      pickers = {
        find_files = { theme = "ivy" },
        git_files = { theme = "ivy" },
        buffers = {
          mappings = {
            i = {
              ["<C-d>"] = "delete_buffer",
            },
          },
        },
      },
    },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>",            desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>",             desc = "Live grep" },
      { "<leader>fa", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Find workspace symbols" },
      { "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>",  desc = "Find document symbols" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>",               desc = "Find buffers" },
      { "<leader>gf", "<cmdTelescope git_files<cr>",              desc = "Find git files" },
      { "<leader>gc", "<cmd>Telescope git_commits<cr>",           desc = "Find git commits" },
      { "<leader>gb", "<cmd>Telescope git_bcommits<cr>",          desc = "Find buffer git commits" },
      { "<leader>gs", "<cmd>Telescope git_status<cr>",            desc = "Find git status" },
      { "<leader>gr", "<cmd>Telescope git_branches<cr>",          desc = "Find git branches" },
    },
  },
}
