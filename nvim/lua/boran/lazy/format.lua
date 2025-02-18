return {
  {
    'stevearc/conform.nvim',
    opts = {},
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          python = { "ruff_fix", "ruff_format" },
          c = { "clang-format" },
          json = { "biome" },
          jsonc = { "biome" },
          markdown = { "markdownlint" },
          sh = { "shfmt" },
        },
        default_format_opts = {
          lsp_format = "fallback",
        },
        format_on_save = {
          lsp_format = "fallback",
          timeout_ms = 500,
        }
      })
    end,
  },
}
