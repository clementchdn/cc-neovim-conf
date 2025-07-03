return {
	"kylechui/nvim-surround",
	version = "*", -- Use for stability; omit to  `main` branch for the latest features
	-- -- -- Just the defaults copied here.
	config = function()
		vim.keymap.set("n", "ds", "<Plug>Dsurround")
		vim.keymap.set("n", "cs", "<Plug>Csurround")
		vim.keymap.set("n", "cS", "<Plug>CSurround")
		vim.keymap.set("n", "ys", "<Plug>Ysurround")
		vim.keymap.set("n", "yS", "<Plug>YSurround")
		vim.keymap.set("n", "yss", "<Plug>Yssurround")
		vim.keymap.set("n", "ySs", "<Plug>YSsurround")
		vim.keymap.set("n", "ySS", "<Plug>YSsurround")

		-- The conflicting ones. Note that `<Plug>(leap-cross-window)`
		-- _does_ work in Visual mode, if jumping to the same buffer,
		-- so in theory, `gs` could be useful for Leap too...
		vim.keymap.set("x", "gs", "<Plug>VSurround")
		vim.keymap.set("x", "gS", "<Plug>VgSurround")
		vim.notify("surrouuund")
	end,
}
