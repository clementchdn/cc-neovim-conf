require("neogen").setup({ snippet_engine = "luasnip" })

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<Leader>nf", ":lua require('neogen').generate({ type = 'func' })<CR>", opts)
