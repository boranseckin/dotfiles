local lsp = require('lsp-zero')

lsp.preset('recommended');

lsp.ensure_installed({
  'tsserver',
  'eslint',
  'rust_analyzer',
});

-- This is handled by rust-tools
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
    ['<CR>'] = cmp.mapping.confirm({ select = true }),

    -- Ctrl+Space to trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete(),

    -- Disable `C-y` because it's mapped to copilot
    ['<C-y>'] = cmp.mapping.disable,
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

-- Setup rust-tools
local rust_tools = require('rust-tools');

-- Get codelldb from Mason
local path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/");
local codelldb_path = path .. "adapter/codelldb";
local liblldb_path = path .. "lldb/lib/liblldb.dylib";

rust_tools.setup({
  dap = {
    adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
  },
  server = {
    settings = {
      ['rust-analyzer'] = {
        check = {
          command = 'clippy',
          allTargets = false,
        },
      },
    },
  },
  tools = {
    inlay_hints = {
      -- auto = false,
    },
  },
});
