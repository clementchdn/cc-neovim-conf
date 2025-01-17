return {
	"mistricky/codesnap.nvim",
	build = "make",
	config = function()
		require("codesnap").setup({
			-- The save_path must be ends with .png, unless when you specified a directory path,
			-- CodeSnap will append an auto-generated filename to the specified directory path
			-- For example:
			-- save_path = "~/Pictures"
			-- parsed: "~/Pictures/CodeSnap_y-m-d_at_h:m:s.png"
			-- save_path = "~/Pictures/foo.png"
			-- parsed: "~/Pictures/foo.png"
			-- code_font_family = "CaskaydiaCove Nerd Font",
			code_font_family = "JetBrainsMono Nerd Font",
			save_path = "~/Pictures/CodeSnap",
			watermark = "",
			-- watermark_font_family = "JetBrainsMono Nerd Font",
		})
	end,
}
