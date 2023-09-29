require("clement.remap")
require("clement.set")

vim.api.nvim_create_autocmd({"BufNewFile,BufRead"}, {
  pattern = {"*.json"},
  command = "setlocal filetype=jsonc"
})

vim.api.nvim_create_autocmd({"BufNewFile, BufRead"}, {
  pattern = {"*.tf"},
  command = "setlocal filetype=tf"
})