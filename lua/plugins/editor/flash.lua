return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		-- these match Leap's default feel pretty closely
		jump = {
			autojump = true,
			search = {
				ignorecase = true,
				smartcase = true,
			},
		},
		modes = {
			-- makes `/` + search also use flash
			search = {
				enabled = true,
			},
		},
	},
	keys = {
		{
			"s",
			mode = { "n" },
			function()
				require("flash").jump({
					autojump = true,
					search = {
						ignorecase = true,
						smartcase = true,
					},
				})
			end,
			desc = "Flash jump case insensitive",
		},
		{
			"S",
			mode = { "n" },
			function()
				require("flash").jump({
					autojump = true,
				})
			end,
			desc = "Flash jump case sensitive",
		},
	},
}
