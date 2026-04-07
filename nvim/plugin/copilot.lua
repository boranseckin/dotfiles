vim.pack.add({ 'https://github.com/zbirenbaum/copilot.lua' })

require('copilot').setup({
  suggestion = {
    enabled = true,
    auto_trigger = false,
    keymap = { accept = "<C-y>", next = "<C-u>" },
  },
  panel = { enabled = false },
})
