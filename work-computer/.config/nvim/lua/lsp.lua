local cmp = require("cmp")
local util = vim.fs
local luasnip = require("luasnip")
local lspkind = require("lspkind")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Load snippets from honza/vim-snippets (SnipMate format, includes Rust)
require("luasnip.loaders.from_snipmate").lazy_load()
-- Load snippets from VSCode-format plugins (e.g. vim-react-snippets)
require("luasnip.loaders.from_vscode").lazy_load()

vim.o.updatetime = 1000

-- =========================
-- nvim-cmp (completion)
-- =========================

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm({ select = true })
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<Up>"] = cmp.mapping.select_prev_item(),
    ["<Down>"] = cmp.mapping.select_next_item(),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
  }),

--   window = {
--     completion = cmp.config.window.bordered({
--       max_height = 10,
--     }),
--     documentation = cmp.config.window.bordered(),
--   },

	window = {
		completion = {
			border = "rounded",
			winhighlight = "Normal:Pmenu,FloatBorder:PmenuBorder,CursorLine:PmenuSel,Search:None", 
			side_padding = 0,
			max_height = 10
		},

		documentation = {
			border = "rounded",
			winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
		},
	},

  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
  },

  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol_text",
      maxwidth = 50,
    }),
  },
})

-- =========================
-- LSP: rust-analyzer
-- =========================

vim.lsp.config("rust_analyzer", {
  capabilities = capabilities,

	root_markers={ "Cargo.toml" },

  on_attach = function(_, bufnr)
    if vim.lsp.inlay_hint then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end
  end,

  settings = {
    ["rust-analyzer"] = {
      cargo = { allFeatures = true },
      checkOnSave = true,
      check = { command = "clippy" },

      inlayHints = {
        bindingModeHints = { enable = true },
        chainingHints = { enable = true },
        closingBraceHints = { enable = true },
        closureReturnTypeHints = { enable = "always" },
        lifetimeElisionHints = {
          enable = "always",
          useParameterNames = true,
        },
        parameterHints = { enable = true },
        typeHints = { enable = true },
      },
    },
  },
})

vim.lsp.enable("rust_analyzer")

-- =========================
-- LSP: ts_ls
-- =========================

vim.lsp.config("ts_ls", {
  capabilities = capabilities,

	cmd = { "typescript-language-server", "--stdio" },
  root_markers = { "tsconfig.json", "jsconfig.json", "package.json" },

  -- on_attach = function(client, bufnr)
  --   client.server_capabilities.documentFormattingProvider = false
  --   client.server_capabilities.documentRangeFormattingProvider = false

  --   if vim.lsp.inlay_hint then
  --     vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  --   end
  -- end,

	init_options = {
    hostInfo = "neovim",
    preferences = {
      includeCompletionsForModuleExports = true,
      includeCompletionsForImportStatements = true,
    },
  },

  settings = {
    -- 🔑 This is the important part
    tsserver = {
      useWorkspaceDependencies = true,
      -- Empty string = auto-detect nearest node_modules/typescript
      path = "",
    },

    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },

    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
})

vim.lsp.enable("ts_ls")

-- =========================
-- Diagnostics
-- =========================

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
  },
})

vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false })
  end,
})

vim.keymap.set("n", "K", vim.lsp.buf.hover, {
  desc = "Show hover documentation",
})

local function goto_definition_smart()
  local params = vim.lsp.util.make_position_params()

  vim.lsp.buf_request(0, "textDocument/definition", params, function(_, result)
    if result and not vim.tbl_isempty(result) then
      vim.lsp.util.jump_to_location(
        vim.tbl_islist(result) and result[1] or result,
        "utf-8"
      )
      return
    end

    -- fallback to declaration
    vim.lsp.buf_request(0, "textDocument/declaration", params, function(_, decl)
      if decl and not vim.tbl_isempty(decl) then
        vim.lsp.util.jump_to_location(
          vim.tbl_islist(decl) and decl[1] or decl,
          "utf-8"
        )
        return
      end

      -- fallback to references
      vim.lsp.buf.references()
    end)
  end)
end

vim.keymap.set("n", "gd", goto_definition_smart, {
  buffer = bufnr,
  desc = "Go to definition (smart)",
})

-- vim.keymap.set("n", "<D-LeftMouse>", goto_definition_smart, { silent = true })
-- vim.keymap.set("n", "<C-LeftMouse>", goto_definition_smart, { silent = true })

