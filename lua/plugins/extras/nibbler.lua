return {
	"skosulor/nibbler",
	config = function()
		require("nibbler").setup({
			display_enabled = true, -- Set to false to disable real-time display (default: true)
		})
	end,
}
