return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"tomblind/local-lua-debugger-vscode",
	},
	config = function()
		local dap = require("dap")
		vim.notify("salut")
		dap.configurations.lua = {
			{
				type = "local-lua",
				name = "Current file (local-lua-dbg, lua)",
				request = "launch",
				cwd = "${workspaceFolder}",
				program = {
					lua = "lua",
					file = "${file}",
				},
				args = {},
			},
		}
	end,
}
