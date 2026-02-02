return {
	"sindrets/diffview.nvim",
	keys = {
		{
			"<leader>Dfh",
			function()
				local file = vim.fn.expand("%")
				vim.cmd("DiffviewFileHistory " .. vim.fn.fnameescape(file))
			end,
			desc = "Open current file history",
		},
		{
			"<leader>Dft",
			function()
				vim.cmd("DiffviewToggleFiles")
			end,
			desc = "Toggles files panel",
		},
	},
}
