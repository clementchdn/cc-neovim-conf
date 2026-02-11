return {
	"rcarriga/nvim-dap-ui",
	dependencies = {
		"mfussenegger/nvim-dap",
	},
	opts = {
		layouts = {
			{
				elements = {
					{
						id = "stacks",
						size = 0.25,
					},
					{
						id = "watches",
						size = 0.25,
					},
					{
						id = "breakpoints",
						size = 0.25,
					},
					{
						id = "scopes",
						size = 0.25,
					},
				},
				position = "left",
				size = 40,
			},
			{
				elements = {
					-- {
					-- 	id = "repl",
					-- 	size = 0.5,
					-- },
					{
						id = "console",
						size = 1,
					},
				},
				position = "bottom",
				size = 10,
			},
		},
	},
	keys = {
		{
			"<Leader>do",
			function()
				require("dapui").open()
			end,
		},
		{
			"<Leader>dc",
			function()
				require("dapui").close()
			end,
		},
		{
			"<Leader>dh",
			function()
				require("dap.ui.widgets").hover()
			end,
			mode = { "n", "v" },
		},
		{
			"<Leader>dp",
			function()
				require("dap.ui.widgets").preview()
			end,
			mode = { "n", "v" },
		},
		{
			"<Leader>df",
			function()
				require("dap.ui.widgets").centered_float(require("dapui.widgets").frames)
			end,
		},
	},
	config = function(_, opts)
		local dap = require("dap")
		local dapui = require("dapui")
		dapui.setup(opts)

		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open({})
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close({})
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close({})
		end
	end,
}
