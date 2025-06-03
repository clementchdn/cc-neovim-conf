-- For `plugins/markview.lua` users.
return {
	"OXY2DEV/markview.nvim",
	lazy = false,
	dependencies = { "nvim-tree/nvim-web-devicons" },

	-- For blink.cmp's completion
	-- source
	-- dependencies = {
	--     "saghen/blink.cmp"
	-- },
	keys = {
		{
			"<leader>mvt",
			"<CMD>Markview Toggle<CR>",
			desc = "Toggle inline markview",
		},
		{
			"<leader>mvs",
			"<CMD>Markview splitToggle<CR>",
			desc = "Toggle markview split buffer",
		},
	},
	opts = {
		preview = {
			icon_provider = "devicons",
		},
	},
}
