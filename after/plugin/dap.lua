local dap, dapui, dap_virtual_text = require("dap"), require("dapui"), require("nvim-dap-virtual-text")

dapui.setup()
dap_virtual_text.setup()
require("nvim-dap-repl-highlights").setup()
-- require('dap-python').setup('/home/clement/MyWell/mywell-back/.venv/bin/python3.12')
require("dap-go").setup()

dap.adapters.cppdbg = {
	id = "cppdbg",
	type = "executable",
	command = "/home/spring/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
}

-- dap.adapters.xmake = {
-- 	id = "cppdbg",
-- 	type = "executable",
-- 	command = "/home/spring/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
-- }

-- dapui
dapui.setup()
dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end

-- keymap
vim.keymap.set("n", "<F5>", function()
	require("dap").continue()
end)
vim.keymap.set("n", "<F10>", function()
	require("dap").step_over()
end)
vim.keymap.set("n", "<F11>", function()
	require("dap").step_into()
end)
vim.keymap.set("n", "<F12>", function()
	require("dap").step_out()
end)
vim.keymap.set("n", "<Leader>b", function()
	require("dap").toggle_breakpoint()
end)
vim.keymap.set("n", "<Leader>B", function()
	require("dap").set_breakpoint()
end)
vim.keymap.set("n", "<Leader>lp", function()
	require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end)
vim.keymap.set("n", "<Leader>dr", function()
	require("dap").repl.open()
end)
vim.keymap.set("n", "<Leader>dl", function()
	require("dap").run_last()
end)
vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
	require("dap.ui.widgets").hover()
end)
vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
	require("dap.ui.widgets").preview()
end)
vim.keymap.set("n", "<Leader>df", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.frames)
end)
vim.keymap.set("n", "<Leader>ds", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.scopes)
end)

vim.keymap.set("n", "<Leader>do", function()
	dapui.open()
end)
vim.keymap.set("n", "<Leader>dc", function()
	dapui.close()
end)

vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
