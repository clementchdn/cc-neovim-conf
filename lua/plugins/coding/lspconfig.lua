return {
	-- LSP Support
	"neovim/nvim-lspconfig",
	dependencies = {
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
	config = function()
		require("mason").setup({
			pip = {
				install_args = {
					"--proxy",
					"http://10.31.255.65:8080",
				},
			},
		})

		vim.diagnostic.config({
			-- changed default value here to true but to be verified
			virtual_text = true,
			severity_sort = true,
			float = {
				style = "minimal",
				border = "rounded",
				source = true,
				header = "",
				prefix = "",
			},
		})

		require("lspconfig").lua_ls.setup({
			settings = {
				Lua = {
					workspace = {
						userThirdParty = { os.getenv("HOME") .. "/LuaAddons" },
						library = { vim.env.VIMRUNTIME, os.getenv("HOME") .. "/LuaAddons/xmake-luals-addon/library" },
					},
					globals = { "vim" },
				},
			},
		})

		require("mason-lspconfig").setup({
			ensure_installed = {
				-- "gopls",
				"ts_ls",
				"rust_analyzer",
				"clangd",
				"pylsp",
				"lemminx",
			},
		})

		local function on_lsp_attach(_, bufnr)
			local opts = { buffer = bufnr, remap = false }

			-- vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
			vim.keymap.set("n", "K", function()
				vim.lsp.buf.hover()
			end, opts)
			vim.keymap.set("n", "<leader>vws", function()
				vim.lsp.buf.workspace_symbol()
			end, opts)
			vim.keymap.set("n", "<leader>vd", function()
				vim.diagnostic.open_float()
			end, opts)
			vim.keymap.set("n", "[d", function()
				vim.diagnostic.goto_next()
			end, opts)
			vim.keymap.set("n", "]d", function()
				vim.diagnostic.goto_prev()
			end, opts)
			vim.keymap.set("n", "<leader>n", function()
				vim.diagnostic.goto_next()
			end, opts)
			vim.keymap.set("n", "<leader>N", function()
				vim.diagnostic.goto_prev()
			end, opts)
			vim.keymap.set("n", "<leader>vca", function()
				vim.lsp.buf.code_action()
			end, opts)
			-- vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
			vim.keymap.set("n", "<leader>vrn", function()
				vim.lsp.buf.rename()
			end, opts)
			vim.keymap.set("i", "<C-h>", function()
				vim.lsp.buf.signature_help()
			end, opts)
			vim.keymap.set("n", "gD", function()
				vim.lsp.buf.declaration()
			end, opts)
			vim.keymap.set("n", "gt", function()
				vim.lsp.buf.type_definition()
			end, opts)
			vim.keymap.set("n", "<leader>cs", "<cmd>ClangdSwitchSourceHeader<CR>")
		end

		local servers = {
			cssls = {
				settings = {
					css = {
						validate = true,
						lint = {
							unknownAtRules = "ignore",
						},
					},
					scss = {
						validate = true,
						lint = {
							unknownAtRules = "ignore",
						},
					},
					less = {
						validate = true,
						lint = {
							unknownAtRules = "ignore",
						},
					},
				},
			},
		}

		-- volar
		local lspconfig = require("lspconfig")
		lspconfig.ts_ls.setup({
			on_attach = on_lsp_attach,
			init_options = {
				plugins = {
					{
						name = "@vue/typescript-plugin",
						location = "/path/to/@vue/language-server",
						languages = { "vue" },
					},
				},
			},
		})

		lspconfig.volar.setup({
			init_options = {
				vue = {
					hybridMode = false,
				},
			},
		})

		local venv_path = os.getenv("VIRTUAL_ENV")
		local py_path = nil
		-- decide which python executable to use for mypy
		if venv_path ~= nil then
			py_path = venv_path .. "/bin/python3"
		else
			py_path = vim.g.python3_host_prog
		end

		lspconfig.pylsp.setup({
			on_attach = on_lsp_attach,
			settings = {
				pylsp = {
					plugins = {
						pycodestyle = {
							maxLineLength = 100,
						},
						pyflakes = {
							enabled = false,
						},
						black = {
							enabled = true,
							line_length = 120,
						},
						isort = {
							enabled = true,
						},
						rope = {
							enabled = true,
						},
						-- pylsp_mypy = {
						-- 	enabled = true,
						-- 	overrides = { "--python-executable", py_path, true },
						-- 	report_progress = true,
						-- 	live_mode = false,
						-- },
					},
				},
			},
		})

		-- gopls
		-- lspconfig.gopls.setup({
		--     settings = {
		--         gopls = {
		--             analyses = {
		--                 unusedparams = true,
		--             },
		--             staticcheck = true,
		--             gofumpt = true,
		--         },
		--     },
		-- })

		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		-- clangd

		local util = require("lspconfig.util")

		-- https://clangd.llvm.org/extensions.html#switch-between-sourceheader
		local function switch_source_header(bufnr)
			bufnr = util.validate_bufnr(bufnr)
			local clangd_client = util.get_active_client_by_name(bufnr, "clangd")
			local params = { uri = vim.uri_from_bufnr(bufnr) }
			if clangd_client then
				clangd_client.request("textDocument/switchSourceHeader", params, function(err, result)
					if err then
						error(tostring(err))
					end
					if not result then
						print("Corresponding file cannot be determined")
						return
					end
					vim.api.nvim_command("edit " .. vim.uri_to_fname(result))
				end, bufnr)
			else
				print(
					"method textDocument/switchSourceHeader is not supported by any servers active on the current buffer"
				)
			end
		end

		local function find_closest_lua_file(filepath)
			local dir = string.match(filepath, "(.*)/") or "./"
			local substringToRemove = "file://"
			local modifiedDir = dir.gsub(dir, substringToRemove, "")

			local closestFile =
				io.popen("find " .. modifiedDir .. "/.." .. " -type f -name '*.lua' -print -quit 2>/dev/null")
					:read("*a")
			if string.len(closestFile) <= 0 then
				closestFile = io.popen(
					"find " .. modifiedDir .. "/.." .. "/.." .. " -type f -name '*.lua' -print -quit 2>/dev/null"
				):read("*a")
			end
			return closestFile
		end

		local function open_lua_file(bufnr)
			bufnr = util.validate_bufnr(bufnr)
			local current_buffer_path = vim.uri_from_bufnr(bufnr)
			local found_lua_file = find_closest_lua_file(current_buffer_path)
			vim.api.nvim_command("edit " .. vim.uri_to_fname("file://" .. found_lua_file))
		end

		local clangd_root_files = {
			"clang-format",
			".clangd",
			".clang-tidy",
			".clang-format",
			"compile_commands.json",
			"compile_flags.txt",
			"configure.ac", -- AutoTools
		}

		lspconfig.clangd.setup({
			on_attach = on_lsp_attach,
			capabilities = cmp_nvim_lsp.default_capabilities(),
			root_dir = function(fname)
				local root_dir = lspconfig.util.root_pattern(unpack(clangd_root_files))(fname)
					or vim.fn.getcwd() .. "/.vscode"
				return root_dir
			end,
			cmd = {
				"clangd",
				-- "-style=file:clang-format",
				-- "-style=file:" .. vim.fn.getcwd() .. "/clang-format",
				"--offset-encoding=utf-16",
			},
			commands = {
				ClangdSwitchSourceHeader = {
					function()
						switch_source_header(0)
					end,
					description = "Switch between source/header",
				},
				ClangOpenXmake = {
					function()
						open_lua_file(0)
					end,
					description = "Find closest xmake file",
				},
				ToggleInlayHints = {
					function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
					end,
					description = "Toggle inlay hints",
				},
			},
		})

		local luasnip = require("luasnip")
		local cmp = require("cmp")
		local cmp_select = { behavior = cmp.SelectBehavior.Select }
		cmp.setup({
			window = {
				documentation = cmp.config.window.bordered(),
			},
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			sources = {
				{ name = "luasnip" },
				{ name = "nvim_lsp" },
				{ name = "buffer" },
			},
			mapping = cmp.mapping.preset.insert({
				-- confirm completion item
				-- ['<CR>'] = cmp.mapping.confirm({select = false}),
				--
				-- -- toggle completion menu
				-- ['<C-e>'] = cmp_action.toggle_completion(),
				--
				-- -- tab complete
				-- ['<Tab>'] = cmp_action.tab_complete(),
				-- ['<S-Tab>'] = cmp.mapping.select_prev_item(),
				--
				-- -- navigate between snippet placeholder
				-- ['<C-d>'] = cmp_action.luasnip_jump_forward(),
				-- ['<C-b>'] = cmp_action.luasnip_jump_backward(),
				--
				-- -- scroll documentation window
				["<C-u>"] = cmp.mapping.scroll_docs(-5),
				["<C-d>"] = cmp.mapping.scroll_docs(5),

				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				-- ["<CR>"] = cmp.mapping.confirm({ select = false }),
				["<C-Space>"] = cmp.mapping.complete(),
				-- ["<Tab>"] = nil,
				-- ["<S-Tab>"] = nil,

				["<CR>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						if luasnip.expandable() then
							luasnip.expand()
						else
							cmp.confirm({
								select = false,
							})
						end
					else
						cmp.confirm({
							select = false,
						})
						fallback()
					end
				end),

				["<Tab>"] = cmp.mapping(function(fallback)
					if luasnip.locally_jumpable(1) then
						luasnip.jump(1)
					elseif cmp.visible() then
						cmp.select_next_item()
					else
						fallback()
					end
				end, { "i", "s" }),

				["<S-Tab>"] = cmp.mapping(function(fallback)
					if luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					elseif cmp.visible() then
						cmp.select_prev_item()
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
		})
	end,
}
