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
    {
        name = "Launch with args",
        type = "cppdbg",
        request = "launch",
        program = function()
            vim.notify(require("xmake.project").info.target.exec_path)
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
    },
}
