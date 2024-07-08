local dap = require("dap")

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
		stopAtEntry = false,
	},
}
