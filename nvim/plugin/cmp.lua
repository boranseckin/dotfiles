vim.pack.add({
  'https://github.com/hrsh7th/nvim-cmp',
  'https://github.com/hrsh7th/cmp-nvim-lsp',
  'https://github.com/hrsh7th/cmp-nvim-lsp-signature-help',
  'https://github.com/hrsh7th/cmp-path',
  'https://github.com/hrsh7th/cmp-buffer',
  'https://github.com/hrsh7th/cmp-cmdline',
})

local cmp = require("cmp")

cmp.setup({
  preselect = false,
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "nvim_lsp_signature_help" },
    { name = "buffer" },
    { name = "path" },
  }),
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ["<CR>"]    = cmp.mapping.confirm({ select = false }),
    ["<Down>"]  = cmp.mapping.select_next_item({ behavior = "select" }),
    ["<Up>"]    = cmp.mapping.select_prev_item({ behavior = "select" }),
    ["<Tab>"]   = cmp.mapping.select_next_item({ behavior = "select" }),
    ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = "select" }),
    ["<C-u>"]   = cmp.mapping.scroll_docs(-4),
    ["<C-d>"]   = cmp.mapping.scroll_docs(4),
    ["<C-e>"]   = cmp.mapping(function()
      if cmp.visible() then cmp.abort() else cmp.complete() end
    end, { "i" }),
  }),
  formatting = {
    fields = { "abbr", "kind" },
  },
})

-- Use buffer source for `/` and `?`
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':'
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  }),
  matching = { disallow_symbol_nonprefix_matching = false }
})
