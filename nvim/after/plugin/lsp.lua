require("fidget").setup({
  progress = { display = { done_ttl = 5, }, },
  notification = { window = { winblend = 0, }, },
})

local lsp = require('lsp-zero')

lsp.preset('recommended');

lsp.ensure_installed({
  'tsserver',
  'eslint',
  'rust_analyzer',
});

-- This is handled by rustaceanvim
lsp.skip_server_setup({'rust_analyzer'});

lsp.set_sign_icons({
  error = '',
  warn = '',
  hint = '',
  info = '',
});

lsp.on_attach(function(_, bufnr)
  lsp.default_keymaps({
    buffer = bufnr,
    omit = { '<F2>', '<F3>', '<F4>', '<C-y>' },
  });

  vim.keymap.set('n', 'gR', '<cmd>lua vim.lsp.buf.rename()<cr>', { buffer = bufnr });
  vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<cr>', { buffer = bufnr });
end);

lsp.format_on_save({
  servers = {
    ["rust-analyzer"] = { "rust" },
  },
});

-- Setup lua language server
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls());

lsp.setup();

-- Enable trailing error messages
vim.diagnostic.config({
  virtual_text = true,
});

-- Setup nvim-cmp
local cmp = require('cmp');

cmp.setup({
  mapping = {
    -- `Enter` key to confirm completion
    ['<CR>'] = cmp.mapping.confirm({ select = false }),

    -- Ctrl+Space to trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete(),

    -- Disable `C-y` because it's mapped to copilot
    ['<C-y>'] = cmp.config.disable,
  },
  experimental = {
    ghost_text = false,
  },
});

cmp.event:on("menu_opened", function()
  vim.b.copilot_suggestion_hidden = true
end)

cmp.event:on("menu_closed", function()
  vim.b.copilot_suggestion_hidden = false
end)

-- `/` cmdline setup
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- `:` cmdline setup
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Use J to join lines using LSP if in a rust file
vim.keymap.set('n', 'J', function()
  if vim.bo.filetype == 'rust' then
    vim.cmd.RustLsp('joinLines')
  else
    vim.cmd('normal! J')
  end
end);

vim.g.rustaceanvim = {
  dap = {
    -- Will be enabled by default on nvim >= 0.10
    autoload_configurations = true,
  },
};
