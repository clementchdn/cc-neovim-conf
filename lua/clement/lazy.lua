local plugins = {
	{
		"folke/noice.nvim",
		dependencies = {
			{
				-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
				"MunifTanjim/nui.nvim",
				-- OPTIONAL:
				--   `nvim-notify` is only needed, if you want to  the notification view.
				--   If not available, we  `mini` as the fallback
				"rcarriga/nvim-notify",
			},
		},
	},

	"olimorris/onedarkpro.nvim",
	{ "catppuccin/nvim", name = "catppuccin" },
	{
		"eldritch-theme/eldritch.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{ "rose-pine/neovim", name = "rose-pine" },

	"rebelot/kanagawa.nvim",

	"xiyaowong/transparent.nvim",

	{
		"nvim-telescope/telescope.nvim",
		-- or                            , branch = '0.1.x',
		dependencies = { { "nvim-lua/plenary.nvim" } },
	},

	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	{ "nvim-treesitter/nvim-treesitter-context" },

	"nvim-treesitter/playground",
	"theprimeagen/harpoon",
	"mbbill/undotree",
	"tpope/vim-fugitive",
	{
		"akinsho/git-conflict.nvim",
		version = "*",
		config = function()
			require("git-conflict").setup()
		end,
	},

	{
		"VonHeikemen/lsp-zero.nvim",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig", lazy = { format = { timeout_ms = 3000 } } },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
		},
	},

	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},

	"eandrju/cellular-automaton.nvim",

	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to  `main` branch for the latest features
	},

	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},

	--[[ {
        'nvim-tree/nvim-tree.lua',
        dependencies = {
            'nvim-tree/nvim-web-devicons', -- optional
        },
    }--]]
	-- nvim-dap for debuggging
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"leoluz/nvim-dap-go",
			"mfussenegger/nvim-dap-python",
			"mxsdev/nvim-dap-vscode-js",
			"LiadOz/nvim-dap-repl-highlights",
		},
	},
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/neotest-python",
			"marilari88/neotest-vitest",
			"alfaix/neotest-gtest",
		},
	},

	{
		"kdheepak/lazygit.nvim",
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},

	{
		"cameron-wags/rainbow_csv.nvim",
		config = true,
		ft = {
			"csv",
			"tsv",
			"csv_semicolon",
			"csv_whitespace",
			"csv_pipe",
			"rfc_csv",
			"rfc_semicolon",
		},
		cmd = {
			"RainbowDelim",
			"RainbowDelimSimple",
			"RainbowDelimQuoted",
			"RainbowMultiDelim",
		},
	},

	-- d to format code with prettier, black, etc
	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup()
		end,
	},

	-- color picker
	{
		"max397574/colortils.nvim",
		cmd = "Colortils",
		config = function()
			require("colortils").setup()
		end,
	},
	{ "NvChad/nvim-colorizer.lua" },

	-- UI
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
	},

	--  {
	--   'nvimdev/dashboard-nvim',
	--   event = 'VimEnter',
	--   config = function()
	--     require('dashboard').setup {
	--       -- config
	--     }
	--   end,
	--   dependencies = { 'nvim-tree/nvim-web-devicons' }
	-- }

	"christoomey/vim-tmux-navigator",

	-- {
	-- 	"zbirenbaum/copilot.lua",
	-- 	cmd = "Copilot",
	-- 	event = "InsertEnter",
	-- 	config = function()
	-- 		require("copilot").setup({
	-- 			suggestion = {
	-- 				enabled = true,
	-- 				auto_trigger = true,
	-- 				debounce = 75,
	-- 				keymap = {
	-- 					accept = "<M-l>",
	-- 					accept_word = false,
	-- 					accept_line = false,
	-- 					next = "<M-]>",
	-- 					prev = "<M-[>",
	-- 					dismiss = "<C-]>",
	-- 				},
	-- 			},
	-- 		})
	-- 	end,
	-- },
	--
	-- {
	-- 	"CopilotC-Nvim/CopilotChat.nvim",
	-- 	branch = "canary",
	-- 	dependencies = {
	-- 		{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
	-- 		{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
	-- 	},
	-- 	opts = {
	-- 		debug = true, -- Enable debugging
	-- 		-- See Configuration section for rest
	-- 	},
	-- 	-- See Commands section for default commands if you want to lazy load on them
	-- },

	"RRethy/vim-illuminate",

	"nvim-pack/nvim-spectre",

	"stevearc/oil.nvim",

	"ggandor/leap.nvim",

	"NStefan002/2048.nvim",

	"ThePrimeagen/vim-be-good",

	"ray-x/go.nvim",
	"ray-x/guihua.lua", -- recommended if need floating window support
	{ "mistricky/codesnap.nvim", build = "make" },
	-- hardtime
	{
		"m4xshen/hardtime.nvim",
		dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
		opts = {
			max_count = 50,
			disabled_keys = {
				["<Up>"] = { "" },
				["<Down>"] = { "" },
				["<Left>"] = { "" },
				["<Right>"] = { "" },
			},
		},
	},
	-- neoscroll for smooth ctrl-D and ctrl-U
	{
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup({})
		end,
	},
	{
		"aaronhallaert/advanced-git-search.nvim",
		cmd = { "AdvancedGitSearch" },
		dependencies = {
			"nvim-telescope/telescope.nvim",
			-- to show diff splits and open commits in browser
			"tpope/vim-fugitive",
			-- to open commits in browser with fugitive
			"tpope/vim-rhubarb",
			-- optional: to replace the diff from fugitive with diffview.nvim
			-- (fugitive is still needed to open in browser)
			-- "sindrets/diffview.nvim",
		},
	},
	{
		"doctorfree/cheatsheet.nvim",
		event = "VeryLazy",
		dependencies = {
			{ "nvim-telescope/telescope.nvim" },
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
		},
		config = function()
			local ctactions = require("cheatsheet.telescope.actions")
			require("cheatsheet").setup({
				bundled_cheetsheets = {
					enabled = { "default", "lua", "markdown", "regex", "netrw", "unicode" },
					disabled = { "nerd-fonts" },
				},
				bundled_plugin_cheatsheets = {
					enabled = {
						"auto-session",
						"goto-preview",
						"octo.nvim",
						"telescope.nvim",
						"vim-easy-align",
						"vim-sandwich",
					},
					disabled = { "gitsigns" },
				},
				include_only_installed_plugins = true,
				telescope_mappings = {
					["<CR>"] = ctactions.select_or_fill_commandline,
					["<A-CR>"] = ctactions.select_or_execute,
					["<C-Y>"] = ctactions.copy_cheat_value,
					-- ["<C-E>"] = ctactions.edit_user_cheatsheet,
				},
			})
		end,
	},
	{
		"chrishrb/gx.nvim",
		keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
		cmd = { "Browse" },
		init = function()
			vim.g.netrw_nogx = 1 -- disable netrw gx
		end,
		dependencies = { "nvim-lua/plenary.nvim" },
		config = true, -- default settings
		submodules = false, -- not needed, submodules are required only for tests

		-- you can specify also another config if you want
		config = function()
			require("gx").setup({
				open_browser_app = "xdg-open", -- specify your browser app; default for macOS is "open", Linux "xdg-open" and Windows "powershell.exe"
				open_browser_args = { "" }, -- specify any arguments, such as --background for macOS' "open".
				handlers = {
					plugin = true, -- open plugin links in lua (e.g. packer, lazy, ..)
					github = true, -- open github issues
					brewfile = true, -- open Homebrew formulaes and casks
					package_json = true, -- open dependencies from package.json
					search = true, -- search the web/selection on the web if nothing else is found
					go = true, -- open pkg.go.dev from an import statement (uses treesitter)
					jira = { -- custom handler to open Jira tickets (these have higher precedence than builtin handlers)
						name = "jira", -- set name of handler
						handle = function(mode, line, _)
							local ticket = require("gx.helper").find(line, mode, "(%u+-%d+)")
							if ticket and #ticket < 20 then
								return "http://jira.company.com/browse/" .. ticket
							end
						end,
					},
					rust = { -- custom handler to open rust's cargo packages
						name = "rust", -- set name of handler
						filetype = { "toml" }, -- you can also set the required filetype for this handler
						filename = "Cargo.toml", -- or the necessary filename
						handle = function(mode, line, _)
							local crate = require("gx.helper").find(line, mode, "(%w+)%s-=%s")

							if crate then
								return "https://crates.io/crates/" .. crate
							end
						end,
					},
				},
				handler_options = {
					search_engine = "google", -- you can select between google, bing, duckduckgo, ecosia and yandex
					search_engine = "https://search.brave.com/search?q=", -- or you can pass in a custom search engine
					select_for_search = false, -- if your cursor is e.g. on a link, the pattern for the link AND for the word will always match. This disables this behaviour for default so that the link is opened without the select option for the word AND link

					git_remotes = { "upstream", "origin" }, -- list of git remotes to search for git issue linking, in priority
					git_remotes = function(fname) -- you can also pass in a function
						if fname:match("myproject") then
							return { "mygit" }
						end
						return { "upstream", "origin" }
					end,

					git_remote_push = false, -- use the push url for git issue linking,
					git_remote_push = function(fname) -- you can also pass in a function
						return fname:match("myproject")
					end,
				},
			})
		end,
	},
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
	-- {                                        -- optional completion source for require statements and module annotations
	--   "hrsh7th/nvim-cmp",
	--   opts = function(_, opts)
	--     opts.sources = opts.sources or {}
	--     table.insert(opts.sources, {
	--       name = "lazydev",
	--       group_index = 0, -- set group index to 0 to skip loading LuaLS completions
	--     })
	--   end,
	-- },
	-- Lua
	{
		"folke/twilight.nvim",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	{
		"folke/zen-mode.nvim",
		opts = {
			plugins = {
				twilight = { enabled = false },
				tmux = { enables = true },
			},
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	{
		"Mythos-404/xmake.nvim",
		branch = "v2",
		-- lazy = true,
		-- event = "BufReadPost xmake.lua",
		config = true,
		dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
	},
	{
		"johmsalas/text-case.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("textcase").setup({})
			require("telescope").load_extension("textcase")
		end,
		-- keys = {
		-- 	"ga", -- Default invocation prefix
		-- 	{ "ga.", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "x" }, desc = "Telescope" },
		-- },
		-- cmd = {
		-- 	-- NOTE: The Subs command name can be customized via the option "substitude_command_name"
		-- 	"Subs",
		-- 	"TextCaseOpenTelescope",
		-- 	"TextCaseOpenTelescopeQuickChange",
		-- 	"TextCaseOpenTelescopeLSPChange",
		-- 	"TextCaseStartReplacingCommand",
		-- },
		-- If you want to use the interactive feature of the `Subs` command right away, text-case.nvim
		-- has to be loaded on startup. Otherwise, the interactive feature of the `Subs` will only be
		-- available after the first executing of it or after a keymap of text-case.nvim has been used.
		lazy = false,
	},
	{
		"Zeioth/dooku.nvim",
		event = "VeryLazy",
		opts = {
			-- your config options here
		},
	},
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
	},
	{
		"danymat/neogen",
		config = true,
		-- Uncomment next line if you want to follow only stable versions
		-- version = "*"
	},
	-- cppman
	{
		"madskjeldgaard/cppman.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },

		config = function()
			local cppman = require("cppman")
			cppman.setup()

			-- Make a keymap to open the word under cursor in CPPman
			vim.keymap.set("n", "<leader>cm", function()
				cppman.open_cppman_for(vim.fn.expand("<cword>"))
			end)

			-- Open search box
			vim.keymap.set("n", "<leader>cc", function()
				cppman.input()
			end)
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
	},
	{
		"m00qek/baleia.nvim",
		branch = "linebreaks",
		version = "*",
		config = function()
			vim.g.baleia = require("baleia").setup({ log = "DEBUG" })

			-- Command to colorize the current buffer
			vim.api.nvim_create_user_command("BaleiaColorize", function()
				vim.g.baleia.once(vim.api.nvim_get_current_buf())
			end, { bang = true })

			-- Command to show logs
			vim.api.nvim_create_user_command("BaleiaLogs", vim.g.baleia.logger.show, { bang = true })
		end,
	},

	{ "RaafatTurki/hex.nvim" },
}

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		{ import = "plugins.UI" },
		{ import = "plugins.debugger" },
		{ import = "plugins.coding" },
		{ import = "plugins.editor" },
		{ import = "plugins.extras" },
		{ import = "plugins.git" },
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})

-- it seems that nvim-surround.setup() must be called after loading other plugins for it to work
require("nvim-surround").setup({
	surrounds = {
		["s"] = {
			add = function()
				vim.notify("salut")
				return { { "{t('" }, { "')}" } }
			end,
		},
	},
})
