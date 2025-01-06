return {
	"theprimeagen/harpoon",
	config = function()
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")

		require("harpoon").setup({
			tabline = true,
			tabline_prefix = "  ",
			tabline_suffix = "",
		})

		vim.keymap.set("n", "<leader>a", mark.toggle_file)
		vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

		vim.keymap.set("n", "<A-h>", function()
			ui.nav_file(1)
		end)
		vim.keymap.set("n", "<A-j>", function()
			ui.nav_file(2)
		end)
		vim.keymap.set("n", "<A-k>", function()
			ui.nav_file(3)
		end)
		vim.keymap.set("n", "<A-l>", function()
			ui.nav_file(4)
		end)
		vim.keymap.set("n", "<A-m>", function()
			ui.nav_file(5)
		end)
		vim.keymap.set("n", "<A-x>", mark.clear_all)
	end,
}
