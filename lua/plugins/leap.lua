return {
	"ggandor/leap.nvim",
	config = function()
		local leap = require("leap")

		vim.g["surround_no_mappings"] = 1
		-- leap.create_default_mappings()
		vim.keymap.set({ "n", "x" }, "s", "<Plug>(leap-forward)")
		vim.keymap.set({ "n", "x" }, "S", "<Plug>(leap-backward)")

		leap.opts.special_keys.prev_target = "<bs>"
		leap.opts.special_keys.prev_group = "<bs>"
		require("leap.user").set_repeat_keys("<cr>", "<bs>")

		vim.g["surround_no_mappings"] = 1
		-- Just the defaults copied here.
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
	end,
}
