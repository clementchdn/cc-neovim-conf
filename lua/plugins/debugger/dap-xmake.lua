return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"leoluz/nvim-dap-go",
		"mfussenegger/nvim-dap-python",
		"mxsdev/nvim-dap-vscode-js",
		"LiadOz/nvim-dap-repl-highlights",
	},
	config = function()
		local dap = require("dap")
		local path = vim.fn.getcwd()
		require("dap-python").setup(path .. "/.venv/bin/python")

		dap.configurations.c = {
			{
				name = "Launch file",
				type = "cppdbg",
				request = "launch",
				program = function()
					return require("xmake.project").info.target.exec_path
				end,
				cwd = "${workspaceFolder}",
				stopAtEntry = true,
			},
		}

		dap.configurations.cpp = {
			{
				name = "Launch file",
				type = "cppdbg",
				request = "launch",
				program = function()
					return require("xmake.project").info.target.exec_path
				end,
				cwd = "${workspaceFolder}",
				stopAtEntry = true,
			},
			{
				name = "Launch with args",
				type = "cppdbg",
				request = "launch",
				program = function()
					return require("xmake.project").info.target.exec_path
				end,
				args = function()
					return vim.split(vim.fn.input("Arguments: "), " ") -- Prompt for args
				end,
				cwd = "${workspaceFolder}",
				stopAtEntry = false,
				setupCommands = {
					{
						description = "Enable pretty-printing",
						text = "-enable-pretty-printing",
						ignoreFailures = false,
					},
				},
				logging = {
					trace = true,
					traceResponse = true,
					engineLogging = true,
					programOutput = true,
					exceptions = true,
				},
			},
			{
				name = "Launch " .. os.getenv("HOME") .. "/SPRINGV13.1.0/Spring/SPRINGCmd" .. " with args",
				type = "cppdbg",
				request = "launch",
				program = function()
					return os.getenv("HOME") .. "/SPRINGV13.1.0/Spring/SPRINGCmd"
				end,
				args = function()
					return vim.split(vim.fn.input("Arguments: "), " ") -- Prompt for args
				end,
				cwd = "${workspaceFolder}",
				stopAtEntry = true,
				setupCommands = {
					{
						description = "Enable pretty-printing",
						text = "-enable-pretty-printing",
						ignoreFailures = false,
					},
				},
				logging = {
					trace = true,
					traceResponse = true,
					engineLogging = true,
					programOutput = true,
					exceptions = true,
				},
			},
		}

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
				args = function()
					return vim.split(vim.fn.input("Arguments: "), " ") -- Prompt for args
				end,
			},
		}
		-- dap.configurations.python = {
		-- 	{
		-- 		type = "python",
		-- 		request = "launch",
		-- 		name = "Launch file with args",
		-- 		program = "${file}",
		-- 		cwd = "${workspaceFolder}",
		-- 		args = function()
		-- 			return vim.split(vim.fn.input("Arguments: "), " ") -- Prompt for args
		-- 		end,
		-- 	},
		-- }
	end,
}
