local M = {}

-- Find the "assets/locales" folder by walking upward
local function find_locales_root(start_path)
	local dir = vim.fn.fnamemodify(start_path, ":p")
	while dir ~= "/" do
		local candidate = dir .. "/assets/locales"
		if vim.fn.isdirectory(candidate) == 1 then
			return candidate
		end
		dir = vim.fn.fnamemodify(dir, ":h")
	end
	return nil
end

function M.SwitchLocale()
	local current_file = vim.fn.expand("%:t") -- e.g. "common.json"
	local current_dir = vim.fn.expand("%:p:h")
	local locales_root = find_locales_root(current_dir)

	if not locales_root then
		vim.notify("Could not locate assets/locales directory", vim.log.levels.ERROR)
		return
	end

	-- Collect available locale codes
	local locales = vim.fn.glob(locales_root .. "/*", 0, 1)
	local codes = {}

	for _, l in ipairs(locales) do
		if vim.fn.isdirectory(l) == 1 then
			table.insert(codes, vim.fn.fnamemodify(l, ":t"))
		end
	end

	if #codes == 0 then
		vim.notify("No locale folders found in " .. locales_root, vim.log.levels.ERROR)
		return
	end

	-- Ask user for target locale
	vim.ui.select(codes, { prompt = "Switch to locale:" }, function(choice)
		if not choice then
			return
		end

		local target_file = string.format("%s/%s/%s", locales_root, choice, current_file)

		if vim.fn.filereadable(target_file) == 1 then
			vim.cmd("edit " .. target_file)
		else
			vim.notify("File does not exist: " .. target_file, vim.log.levels.WARN)
		end
	end)
end

-- Create :SwitchLocale command
vim.api.nvim_create_user_command("SwitchLocale", M.SwitchLocale, {})
vim.keymap.set({ "n" }, "<leader>cl", M.SwitchLocale)

return M
