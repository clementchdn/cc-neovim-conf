return {
	"athar-qadri/weather.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim", -- Required for HTTP requests
		"rcarriga/nvim-notify", -- Optional, for notifications
	},
	config = function()
		local weather = require("weather")
		weather:setup({
			settings = {
				update_interval = 60 * 10 * 1000, -- 10 minutes
				minimum_magnitude = 5,
				location = { lat = 43.64, lon = 1.45 },
				temperature_unit = "celsius",
			},
		})
		-- require("weather.notify").start() -- Start notifications
	end,
}
