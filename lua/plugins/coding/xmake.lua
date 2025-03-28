return {
	"Mythos-404/xmake.nvim",
	branch = "v2",
	lazy = true,
	event = { "BufReadPost xmake.lua", "BufReadPost *.cpp" },
	config = true,
	dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
}
