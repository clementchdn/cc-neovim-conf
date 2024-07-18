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

	"xiyaowong/transparent.nvim",

	{
		"nvim-telescope/telescope.nvim",
		-- or                            , branch = '0.1.x',
		dependencies = { { "nvim-lua/plenary.nvim" } },
	},

	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

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

	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = {
					enabled = true,
					auto_trigger = true,
					debounce = 75,
					keymap = {
						accept = "<M-l>",
						accept_word = false,
						accept_line = false,
						next = "<M-]>",
						prev = "<M-[>",
						dismiss = "<C-]>",
					},
				},
			})
		end,
	},

	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		opts = {
			debug = true, -- Enable debugging
			-- See Configuration section for rest
		},
		-- See Commands section for default commands if you want to lazy load on them
	},

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
			},
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	{
		"Mythos-404/xmake.nvim",
		lazy = true,
		event = "BufReadPost xmake.lua",
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
}

require("lazy").setup(plugins, {})
