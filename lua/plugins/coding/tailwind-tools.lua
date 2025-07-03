-- tailwind-tools.lua
return {
	"luckasRanarison/tailwind-tools.nvim",
	tag = "v0.3.2",
	name = "tailwind-tools",
	build = ":UpdateRemotePlugins",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-telescope/telescope.nvim", -- optional
		"neovim/nvim-lspconfig", -- optional
	},
	opts = {}, -- your configuration
}
