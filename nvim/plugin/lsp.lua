vim.pack.add({
  'https://github.com/neovim/nvim-lspconfig',
  -- 'https://github.com/mrcjkb/rustaceanvim',
  'https://github.com/nvim-treesitter/nvim-treesitter-context',
})

vim.lsp.config('*', {
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

-- rust-analyzer clippy instead of check
vim.lsp.config('rust_analyzer', {
  settings = {
    ['rust-analyzer'] = {
      check = { command = 'clippy' },
    }
  },
})

-- qmlls isn't on PATH; it ships inside the qt6-declarative package
vim.lsp.config('qmlls', {
  cmd = { '/usr/lib/qt6/bin/qmlls' },
})

vim.lsp.enable({
  'lua_ls',
  'rust_analyzer',
  'clangd',
  'bashls',
  'qmlls',
})

-- keybinds
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
vim.keymap.set("n", "gr", vim.lsp.buf.rename, { desc = "Rename" })
vim.keymap.set("n", "ga", vim.lsp.buf.code_action, { desc = "Code actions" })

vim.keymap.set("n", "[d", function()
  vim.diagnostic.jump({
    count = -1,
    on_jump = function()
      vim.diagnostic.open_float({ focus = false })
    end
  })
end, { desc = "Previous diagnostic" })

vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump({
    count = 1,
    on_jump = function()
      vim.diagnostic.open_float({ focus = false })
    end
  })
end, { desc = "Next diagnostic" })

vim.keymap.set("n", "<leader>ih", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle inlay hints" })

vim.keymap.set("n", "<leader>id", function()
  local current_config = vim.diagnostic.config().virtual_text
  vim.diagnostic.config({ virtual_text = not current_config })
end, { desc = "Toggle inline diagnostics" })

-- auto format
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})
