# default options
vim.opt.guicursor = "n-v-c:block-Cursor/lCursor"
vim.opt.guicursor = vim.opt.guicursor + "ve:ver35-Cursor"
vim.opt.guicursor =	vim.opt.guicursor + "o:hor50-Cursor"
vim.opt.guicursor = vim.opt.guicursor +	"i-ci:ver25-Cursor/lCursor"
vim.opt.guicursor = vim.opt.guicursor + "r-cr:hor20-Cursor/lCursor"
vim.opt.guicursor = vim.opt.guicursor + "sm:block-Cursor"

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "120"

vim.g.mapleader = " "
