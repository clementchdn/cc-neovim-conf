return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "ThePrimeagen/harpoon", opt = true },
	opts = function()
		local xmake_component = {
			function()
				local xmake = require("xmake.project").info
				if xmake.target.tg == "" then
					return ""
				end
				return xmake.target.tg .. "(" .. xmake.mode .. ")"
			end,

			cond = function()
				return vim.o.columns > 100
			end,

			on_click = function()
				require("xmake.project._menu").init() -- Add the on-click ui
			end,
		}

		return {
			options = {
				icons_enabled = true,
				theme = "auto",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = false,
				refresh = {
					statusline = 500,
					tabline = 500,
					winbar = 1000,
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { { "filename", path = 1 } },
				lualine_w = {
					{
						function()
							if not vim.g.loaded_xmake then
								return ""
							end
							local Info = require("xmake.info")
							if Info.mode.current == "" then
								return ""
							end
							if Info.target.current == "" then
								return "Xmake: Not Select Target"
							end
							return ("%s(%s)"):format(Info.target.current, Info.mode.current)
						end,
						cond = function()
							return vim.o.columns > 100
						end,
					},
				},
				lualine_x = { require("weather.lualine").default_c(), "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			-- inactive_sections = {
			-- 	lualine_a = {},
			-- 	lualine_b = {},
			-- 	lualine_c = { "filename" },
			-- 	lualine_x = { "location" },
			-- 	lualine_y = {},
			-- 	lualine_z = {
			-- 		"location",
			-- 	},
			-- },
			tabline = {
				lualine_c = {
					{ require("harpoon_files").lualine_component },
				},
			},
			winbar = {},
			inactive_winbar = {},
			extensions = {},
		}
	end,
}
