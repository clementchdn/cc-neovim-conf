require("clement.remap")
require("clement.set")
require("clement.lazy")

-- vim.api.nvim_create_autocmd({ "BufNewFile,BufRead" }, {
--   pattern = { "*.json", "*.jsonc", "*.gltf" },
--   command = "setlocal filetype=jsonc"
-- })
--
-- vim.api.nvim_create_autocmd({ "BufNewFile, BufRead" }, {
--   pattern = { "*.tf" },
--   command = "setlocal filetype=tf"
-- })

vim.g.netrw_keepdir = 0
vim.opt.formatoptions:remove("c")
vim.opt.formatoptions:remove("r")
vim.opt.formatoptions:remove("o")

local function rinex_cleanup()
	-- Prompt for RINEX type
	vim.ui.input({ prompt = "RINEX file type (O or B): " }, function(rinex_type)
		if not rinex_type then
			return
		end
		rinex_type = rinex_type:upper()
		if rinex_type ~= "O" and rinex_type ~= "B" then
			vim.notify("Invalid RINEX type (use O or B)", vim.log.levels.ERROR)
			return
		end

		-- Prompt for constellation letter
		vim.ui.input({ prompt = "Constellation letter to keep (G or E): " }, function(keep_letter)
			if not keep_letter then
				return
			end
			keep_letter = keep_letter:upper()
			if not keep_letter:match("^[A-Z]$") then
				vim.notify("Invalid capital letter", vim.log.levels.ERROR)
				return
			end

			local bufnr = vim.api.nvim_get_current_buf()
			local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

			-- Build patterns dynamically
			local start_pat = "^[A-Z]%d%d"
			local keep_pat = "^" .. keep_letter .. "%d%d"

			local i = 1
			while i <= #lines do
				-- Block start: any capital letter + 2 digits EXCEPT chosen letter
				if lines[i]:match(start_pat) and not lines[i]:match(keep_pat) then
					local start = i

					-- Find end of block (before next keep_letter block)
					local j = i + 1
					while j <= #lines and not lines[j]:match(keep_pat) do
						j = j + 1
					end
					local finish = j - 1

					-- Delete lines in reverse order
					for k = finish, start, -1 do
						local is_arrow = lines[k]:match("^>")
						local delete_line = (rinex_type == "B") or (rinex_type == "O" and not is_arrow)

						if delete_line then
							vim.api.nvim_buf_set_lines(bufnr, k - 1, k, false, {})
							table.remove(lines, k)
						end
					end

					i = start
				else
					i = i + 1
				end
			end

			vim.notify(
				string.format("RINEX cleanup done (type=%s, keep=%s)", rinex_type, keep_letter),
				vim.log.levels.INFO
			)
		end)
	end)
end

vim.api.nvim_create_user_command("RinexCleanup", rinex_cleanup, { desc = "Clean RINEX blocks (configurable O/B, G/E)" })

local C = require("catppuccin.palettes").get_palette(flavour)
-- Make tabline background transparent
vim.api.nvim_set_hl(0, "TabLine", { bg = "none" })
vim.api.nvim_set_hl(0, "TabLineSel", { bg = "none", bold = true })
vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none" })
