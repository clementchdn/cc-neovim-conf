require("clement.remap")
require("clement.set")
require("clement.lazy")

-- vim.api.nvim_create_autocmd({ "BufNewFile,BufRead" }, {
--   pattern = { "*.json", "*.jsonc", "*.gltf" },
--   command = "setlocal filetype=jsonc"
-- })
--
-- vim.api.nvim_create_autocmd({ "BufNewFile, BufRead" }, {
--   pattern = { "*.tf" },
--   command = "setlocal filetype=tf"
-- })

vim.g.netrw_keepdir = 0
vim.opt.formatoptions:remove("c")
vim.opt.formatoptions:remove("r")
vim.opt.formatoptions:remove("o")
