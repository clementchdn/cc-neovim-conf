return {
	"sindrets/diffview.nvim",
	cmd = {
		"DiffviewOpen",
		"DiffviewClose",
		"DiffviewToggleFiles",
		"DiffviewFileHistory",
	},
	dependencies = { "nvim-lua/plenary.nvim" },
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
