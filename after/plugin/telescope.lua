require('telescope').setup({
  defaults = {
    file_ignore_patterns = { 'node_modules', 'dist', 'build', '.git', '.venv' },
  }
})
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', function() builtin.find_files({hidden=true, unrestricted=true}) end, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
vim.keymap.set('n', '<leader>vrr', builtin.lsp_references, {})

require("telescope").load_extension("noice")
