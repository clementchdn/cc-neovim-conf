require('transparent').clear_prefix('lualine')

vim.keymap.set("n", "<leader>t", "<cmd>lua require('transparent').toggle()<CR>")
