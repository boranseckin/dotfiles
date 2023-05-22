require('copilot').setup({
  suggestion = {
    enabled = true,
    auto_trigger = false,
    keymap = {
      accept = "<C-y>",
      next = "<C-u>",
    }
  },
  panel = { enabled = false },
  filetypes = {
    -- Disable copilot in dap-repl
    -- https://github.com/neovim/neovim/issues/17615#issuecomment-1176385988
    ["dapl-repl"] = false
  }
})
