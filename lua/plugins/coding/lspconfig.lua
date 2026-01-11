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

		require("mason-lspconfig").setup({
			automatic_enable = false,
			ensure_installed = {
				"gopls",
				"rust_analyzer",
				"clangd",
				"pylsp",
				"lemminx",
				"eslint",
				"ts_ls",
				"tailwindcss",
			},
		})

		local function on_lsp_attach(_, bufnr)
			local opts = { buffer = bufnr, remap = false }

			-- vim.keymap.set("n", "gd", function()
			-- 	vim.lsp.buf.definition()
			-- end, opts)
			vim.keymap.set("n", "K", function()
				vim.lsp.buf.hover()
			end, opts)
			vim.keymap.set("n", "<leader>vws", function()
				vim.lsp.buf.workspace_symbol()
			end, opts)
			vim.keymap.set("n", "<leader>vd", function()
				vim.diagnostic.open_float()
			end, opts)
			vim.keymap.set("n", "<leader>nd", function()
				vim.diagnostic.jump({ diagnostic = vim.diagnostic.get_next() })
			end, opts)
			vim.keymap.set("n", "<leader>Nd", function()
				vim.diagnostic.jump({ diagnostic = vim.diagnostic.get_prev() })
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
		end

		vim.lsp.config("lua_ls", {
			on_attach = on_lsp_attach,
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

		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		-- volar
		vim.lsp.config("ts_ls", {
			root_dir = function(bufnr, on_dir)
				-- The project root is where the LSP can be started from
				-- As stated in the documentation above, this LSP supports monorepos and simple projects.
				-- We select then from the project root, which is identified by the presence of a package
				-- manager lock file.
				local root_markers =
					{ "package-lock.json", "tsconfig.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock" }
				-- Give the root markers equal priority by wrapping them in a table
				root_markers = vim.fn.has("nvim-0.11.3") == 1 and { root_markers, { ".git" } }
					or vim.list_extend(root_markers, { ".git" })
				-- exclude deno
				local deno_path = vim.fs.root(bufnr, { "deno.json", "deno.jsonc", "deno.lock" })
				local project_root = vim.fs.root(bufnr, root_markers)
				if deno_path and (not project_root or #deno_path >= #project_root) then
					return
				end
				-- We fallback to the current working directory if no project root is found
				on_dir(project_root or vim.fn.getcwd())
			end,
			on_attach = on_lsp_attach,
			capabilities = cmp_nvim_lsp.default_capabilities(),
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

		vim.lsp.config("vue_ls", {
			init_options = {
				vue = {
					hybridMode = false,
				},
			},
		})

		local base_on_attach = vim.lsp.config.eslint.on_attach
		vim.lsp.config("eslint", {
			on_attach = function(client, bufnr)
				if not base_on_attach then
					return
				end

				base_on_attach(client, bufnr)
				on_lsp_attach(client, bufnr)
				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufnr,
					command = "LspEslintFixAll",
				})
			end,
		})

		local venv_path = os.getenv("VIRTUAL_ENV")
		local py_path = nil
		-- decide which python executable to use for mypy
		if venv_path ~= nil then
			py_path = venv_path .. "/bin/python3"
		else
			py_path = vim.g.python3_host_prog
		end

		vim.lsp.config("pylsp", {
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

		-- clangd
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
			if not vim.api.nvim_buf_is_valid(bufnr) then
				return
			end
			local current_buffer_path = vim.uri_from_bufnr(bufnr)
			local found_lua_file = find_closest_lua_file(current_buffer_path)
			vim.api.nvim_command("edit " .. vim.uri_to_fname("file://" .. found_lua_file))
		end

		-- https://clangd.llvm.org/extensions.html#switch-between-sourceheader
		local function switch_source_header(bufnr, client)
			local method_name = "textDocument/switchSourceHeader"
			---@diagnostic disable-next-line:param-type-mismatch
			if not client or not client:supports_method(method_name) then
				return vim.notify(
					("method %s is not supported by any servers active on the current buffer"):format(method_name)
				)
			end
			local params = vim.lsp.util.make_text_document_params(bufnr)
			---@diagnostic disable-next-line:param-type-mismatch
			client:request(method_name, params, function(err, result)
				if err then
					error(tostring(err))
				end
				if not result then
					vim.notify("corresponding file cannot be determined")
					return
				end
				vim.cmd.edit(vim.uri_to_fname(result))
			end, bufnr)
		end

		local function symbol_info(bufnr, client)
			local method_name = "textDocument/symbolInfo"
			---@diagnostic disable-next-line:param-type-mismatch
			if not client or not client:supports_method(method_name) then
				return vim.notify("Clangd client not found", vim.log.levels.ERROR)
			end
			local win = vim.api.nvim_get_current_win()
			local params = vim.lsp.util.make_position_params(win, client.offset_encoding)
			---@diagnostic disable-next-line:param-type-mismatch
			client:request(method_name, params, function(err, res)
				if err or #res == 0 then
					-- Clangd always returns an error, there is no reason to parse it
					return
				end
				local container = string.format("container: %s", res[1].containerName) ---@type string
				local name = string.format("name: %s", res[1].name) ---@type string
				vim.lsp.util.open_floating_preview({ name, container }, "", {
					height = 2,
					width = math.max(string.len(name), string.len(container)),
					focusable = false,
					focus = false,
					title = "Symbol Info",
				})
			end, bufnr)
		end

		vim.lsp.config("clangd", {
			capabilities = {
				textDocument = {
					completion = {
						editsNearCursor = true,
					},
				},
				offsetEncoding = { "utf-8", "utf-16" },
			},
			filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
			---@param init_result ClangdInitializeResult
			on_init = function(client, init_result)
				if init_result.offsetEncoding then
					client.offset_encoding = init_result.offsetEncoding
				end
			end,
			on_attach = function(client, bufnr)
				on_lsp_attach(client, bufnr)
				vim.api.nvim_buf_create_user_command(bufnr, "ClangdShowSymbolInfo", function()
					symbol_info(bufnr, client)
				end, { desc = "Show symbol info" })

				vim.api.nvim_buf_create_user_command(bufnr, "ClangdSwitchSourceHeader", function()
					switch_source_header(bufnr, client)
				end, { desc = "Switch between source/header" })

				vim.api.nvim_buf_create_user_command(bufnr, "ClangdOpenXmake", function()
					open_lua_file(bufnr)
				end, { desc = "Find closest xmake file" })

				vim.keymap.set("n", "<leader>cs", "<CMD>ClangdSwitchSourceHeader<CR>")
			end,
			root_markers = {
				".clangd",
				".clang-tidy",
				".clang-format",
				"compile_commands.json",
				"compile_flags.txt",
				"configure.ac", -- AutoTools
				".git",
			},
			cmd = {
				"clangd",
				-- "-style=file:clang-format",
				-- "-style=file:" .. vim.fn.getcwd() .. "/clang-format",
				"--offset-encoding=utf-16",
			},
		})

		-- gopls
		vim.lsp.config("gopls", {
			on_attach = on_lsp_attach,
			filetypes = { "go", "gomod", "gohtml" },
			settings = {
				gopls = {
					analyses = {
						unusedparams = true,
					},
					staticcheck = true,
					gofumpt = true,
				},
			},
		})

		vim.lsp.config("templ", {
			on_attach = on_lsp_attach,
			capabilities = cmp_nvim_lsp.default_capabilities(),
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

		vim.api.nvim_create_user_command("ToggleInlayHints", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
		end, {})

		vim.lsp.enable({
			"lua_ls",
			"ts_ls",
			"eslint",
			"vue_ls",
			"gopls",
			"pylsp",
			"clangd",
			"templ",
		})
	end,
}
