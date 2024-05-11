return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
    },
    lazy = false,
    keys = {
      { "K",  "<cmd>lua vim.lsp.buf.hover()<cr>",          desc = "Hover" },
      { "gd", "<cmd>lua vim.lsp.buf.definition()<cr>",     desc = "Go to definition" },
      { "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>",    desc = "Go to declaration" },
      { "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", desc = "Go to implementation" },
      { "gr", "<cmd>lua vim.lsp.buf.rename()<cr>",         desc = "Rename" },
      { "ga", "<cmd>lua vim.lsp.buf.code_action()<cr>",    desc = "Show code actions" },
      { "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>",   desc = "Previous diagnostic" },
      { "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>",   desc = "Next diagnostic" },
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require('luasnip')

      cmp.setup({
        preselect = false,
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "nvim_lsp_signature_help" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
          { name = "nvim_lua" },
        }, {
          { name = "buffer" },
        }),
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping.confirm({ select = false }),

          ["<Down>"] = cmp.mapping.select_next_item({ behavior = "select" }),
          ["<Up>"] = cmp.mapping.select_prev_item({ behavior = "select" }),
          ["<Tab>"] = cmp.mapping.select_next_item({ behavior = "select" }),
          ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = "select" }),

          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),

          ["<C-f>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-b>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<C-e>"] = cmp.mapping(function()
            if cmp.visible() then
              cmp.abort()
            else
              cmp.complete()
            end
          end, { "i" }),
        }),
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end
        },
      })

      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        })
      })

      local lspconfig = require("lspconfig")
      local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "rust_analyzer" },
        automatic_installation = true,
        handlers = {
          function(server)
            lspconfig[server].setup({
              capabilities = lsp_capabilities,
            })
          end,
        },
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("FormatOnSave", { clear = true }),
        callback = function(args)
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = args.buf,
            callback = function()
              vim.lsp.buf.format { async = false, id = args.data.client_id }
            end,
          })
        end
      })
    end,
  },
}
