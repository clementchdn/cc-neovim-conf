require("mason").setup({
  pip = {
    install_args = {
      "--proxy", "http://10.31.255.65:8080"
    }
  }
})

local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
  'tsserver',
  'rust_analyzer',
  'clangd',
  'pylsp',
  'lemminx'
})

-- Fix Undefined global 'vim'
lsp.nvim_workspace()

local cmp = require('cmp')

local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ['<CR>'] = cmp.mapping.confirm({ select = false }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.set_preferences({
  suggest_lsp_servers = false,
  sign_icons = {
    error = 'E',
    warn = 'W',
    hint = 'H',
    info = 'I'
  }
})

local function on_lsp_attach(_, bufnr)
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>n", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "<leader>N", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end

local servers = {
  pylsp = {
    pylsp = {
      plugins = {
        pycodestyle = {
          maxLineLength = 100
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

lsp.configure('pylsp', { settings = servers['pylsp'] })
lsp.configure('cssls', { settings = servers['cssls'] })

lsp.on_attach(on_lsp_attach)
lsp.setup()

vim.diagnostic.config({
  virtual_text = true
})

-- require('sonarlint').setup({
--   server = {
--     cmd = {
--       'sonarlint-language-server',
--       -- Ensure that sonarlint-language-server uses stdio channel
--       '-stdio',
--       '-analyzers',
--       -- paths to the analyzers you need, using those for python and java in this example
--       vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarpython.jar"),
--       vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarcfamily.jar"),
--       vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjava.jar"),
--     }
--   },
--   filetypes = {
--     -- Tested and working
--     'python',
--     'cpp',
--     'java',
--   }
-- })
