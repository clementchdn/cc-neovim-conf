-- require("transparent").setup()
--
-- vim.keymap.set("n", "<leader>t", function()
-- 	if vim.g.transparent_enabled then
-- 		vim.api.nvim_set_hl(0, "LineNr", { fg = "#9999ee", blend = 100 })
-- 	else
-- 		vim.api.nvim_set_hl(0, "LineNr", { fg = "#9999ee", blend = 50 })
-- 	end
-- 	require("transparent").toggle()
-- end)
