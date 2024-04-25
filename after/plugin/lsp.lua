require("mason").setup({
  pip = {
    install_args = {
      "--proxy", "http://10.31.255.65:8080"
    }
  }
})

local lsp_zero = require("lsp-zero")

lsp_zero.set_sign_icons({
  error = 'E',
  warn = 'W',
  hint = 'H',
  info = 'I'
})

vim.diagnostic.config({
  -- changed default value here to true but to be verified
  virtual_text = true,
  severity_sort = true,
  float = {
    style = 'minimal',
    border = 'rounded',
    source = true,
    header = '',
    prefix = '',
  },
})

local lua_opts = lsp_zero.nvim_lua_ls()
require('lspconfig').lua_ls.setup(lua_opts)

lsp_zero.preset("recommended")

require('mason-lspconfig').setup({
  ensure_installed = {
    'tsserver',
    'rust_analyzer',
    'clangd',
    'pylsp',
    'lemminx'
  }
})


local function on_lsp_attach(_, bufnr)
  local opts = { buffer = bufnr, remap = false }

  -- vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>n", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "<leader>N", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  -- vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end

local servers = {
  pylsp = {
    pylsp = {
      plugins = {
        pycodestyle = {
          maxLineLength = 140,
        },
        pyflakes = {
          enabled= false,
        },
        black = {
          enabled = true,
          line_length = 140,
        },
        isort = {
          enabled = true
        },
        rope = {
          enabled = true
        }
      }
    }
  },
  cssls = {
    settings = {
      css = {
        validate = true,
        lint = {
          unknownAtRules = 'ignore'
        }
      },
      scss = {
        validate = true,
        lint = {
          unknownAtRules = 'ignore'
        }
      },
      less = {
        validate = true,
        lint = {
          unknownAtRules = 'ignore'
        }
      }
    }
  }
}

lsp_zero.configure('pylsp', { settings = servers['pylsp'] })
lsp_zero.configure('cssls', { settings = servers['cssls'] })

require('mason').setup()
require('mason-lspconfig').setup({
  handlers = {
    lsp_zero.default_setup,
  }
})

lsp_zero.on_attach(on_lsp_attach)
lsp_zero.setup()

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
cmp.setup({
  window = {
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    -- confirm completion item
    -- ['<CR>'] = cmp.mapping.confirm({select = false}),
    --
    -- -- toggle completion menu
    -- ['<C-e>'] = cmp_action.toggle_completion(),
    --
    -- -- tab complete
    -- ['<Tab>'] = cmp_action.tab_complete(),
    -- ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    --
    -- -- navigate between snippet placeholder
    -- ['<C-d>'] = cmp_action.luasnip_jump_forward(),
    -- ['<C-b>'] = cmp_action.luasnip_jump_backward(),
    --
    -- -- scroll documentation window
    -- ['<C-f>'] = cmp.mapping.scroll_docs(-5),
    -- ['<C-d>'] = cmp.mapping.scroll_docs(5),

    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ["<C-Space>"] = cmp.mapping.complete(),
    ['<Tab>'] = nil,
    ['<S-Tab>'] = nil,
  })
})
