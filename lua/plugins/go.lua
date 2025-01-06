return {
	"ray-x/go.nvim",
	dependencies = {
		"ray-x/guihua.lua", -- recommended if need floating window support
	},
	config = function()
		require("go").setup()
		-- Run gofmt + goimport on save

		local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*.go",
			callback = function()
				require("go.format").goimport()
			end,
			group = format_sync_grp,
		})
	end,
}
