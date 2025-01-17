vim.g.mapleader = " "

-- open netrw
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
-- open Oil
vim.keymap.set("n", "<leader>pv", "<cmd>Oil<CR>")

-- move selected lines up
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- move selected lines down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

-- bring next line after end of current line
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- greatest remap ever
vim.keymap.set("x", "<leader>P", [["_dP]])

-- next greatest remap ever : asbjornHaland
-- copy to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- go back to normal mode
vim.keymap.set("i", "<C-c>", "<Esc>")

-- disable Q shortcut
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "qq", "<nop>")

-- no idea, check theprimeagen config
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux new tmux-sessionizer<CR>")

-- format code
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[/\<<C-r><C-w>\>]])
vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- vim.keymap.set(
-- 	"v",
-- 	"<leader>r",
-- 	[[:%s/\%V<C-r>=escape(@", '\\/[]')<CR>/<C-r>=escape(@", '\\/[]')<CR>/gI<Left><Left><Left>]],
-- 	{ noremap = true }
-- )
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
vim.keymap.set("n", "<leader>w", "<cmd>:w!<CR>")

-- vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/clement/packer.lua<CR>");

vim.keymap.set("n", "<leader><leader>", function()
	vim.cmd("so")
end)

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

vim.keymap.set("n", "<leader>da", "<cmd>NoiceDismiss<CR>", { desc = "Dismiss Noice Message" })

-- used to follow link without netrw
-- vim.keymap.set("n", "gx", [[:silent execute '!open ' . shellescape(expand('<cfile>'), 1)<CR>]])

-- toggle number mode
function _G.toggle_number_mode()
	local wo = vim.wo
	wo.number = true
	wo.relativenumber = not wo.relativenumber
end

vim.keymap.set("n", "<leader>tr", toggle_number_mode)
