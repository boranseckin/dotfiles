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
  hint = '',
  info = '',
});

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({
    buffer = bufnr,
    omit = { '<F2>', '<F3>', '<F4>' },
  });

  vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.rename()<cr>', { buffer = bufnr });
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
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    -- Ctrl+Space to trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete(),

    -- Ctrl+y to accept Copilot suggestion
    ['<C-y>'] = cmp.mapping(function(fallback)
      vim.api.nvim_feedkeys(vim.fn['copilot#Accept'](vim.api.nvim_replace_termcodes('<Tab>', true, true, true)), 'n', true);
    end),
  },
  experimental = {
    ghost_text = false,
  },
});

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
        },
      },
    },
  },
  tools = {
    inlay_hints = {
      auto = false,
    },
  },
});
