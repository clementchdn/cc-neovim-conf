vim.cmd('colorscheme onedark')
require('onedarkpro').setup({
  options = {
    transparency = true,
    cursorline = true
  }
})
require('onedarkpro').load()

vim.api.nvim_set_hl(0, "Cursor", { fg = '#999999', bg = '#999999' })
vim.api.nvim_set_hl(0, "CursorReset", { fg = 'white', bg = 'white' })
