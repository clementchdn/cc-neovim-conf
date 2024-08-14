local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local extras = require("luasnip.extras")
local rep = extras.rep
local fmt = require("luasnip.extras.fmt").fmt
local types = require("luasnip.util.types")

require("luasnip.loaders.from_vscode").load({ paths = "~/code-snippets/" })
vim.api.nvim_set_keymap("i", "<C-n>", "<Plug>luasnip-next-choice", {})
vim.api.nvim_set_keymap("s", "<C-n>", "<Plug>luasnip-next-choice", {})
vim.api.nvim_set_keymap("i", "<C-p>", "<Plug>luasnip-prev-choice", {})
vim.api.nvim_set_keymap("s", "<C-p>", "<Plug>luasnip-prev-choice", {})

ls.config.setup({
	history = true,
	update_events = { "TextChanged", "TextChangedI" },
	enable_autosnippets = true,
	ext_opts = {
		[types.insertNode] = {
			active = {
				hl_group = "DiagnosticHint",
				-- virt_text = { { "truc", "DiagnosticHint" } },
			},
			passive = {
				hl_group = "SnippetTabstop",
			},
		},
		[types.choiceNode] = {
			active = {
				virt_text = { { "●", "DiagnosticFloatingInfo" } },
				-- hl_mode = "combine",
			},
		},
	},
})

local function tablelength(T)
	local count = 0
	for _ in pairs(T) do
		count = count + 1
	end
	return count
end

local cpp_function_fmt = [[
{doc}
{virtual} {ret} {name}({params}){const};
]]
local cpp_function_snippet = function()
	return fmt(cpp_function_fmt, {
		doc = d(6, function(args)
			local is_void = string.find(args[1][1], "void")
			return isn(nil, {
				t({ "/**", " @brief " }),
				i(1, "function description"),
				d(2, function()
					local param_str = args[2][1]
					if param_str == "" then
						return sn(1, { t("") })
					end
					local params = vim.split(param_str, ",")
					local nodes = {}
					for index, param in ipairs(params) do
						table.insert(
							nodes,
							sn(
								index,
								fmt("\n\n @param {param_name} {param_desc}", {
									param_name = t(param),
									param_desc = i(1, "description"),
								})
							)
						)
					end
					return sn(1, nodes)
				end),
				d(3, function()
					if is_void == nil then
						return sn(nil, {
							t({ "", " @return " }),
							i(1, "return description"),
						})
					else
						return sn(nil, { t("") })
					end
				end),
				t({ "", "/" }),
			}, "$PARENT_INDENT *")
		end, { 2, 4 }),
		const = c(5, { t(" const"), t("") }),
		name = i(3, "func_name"),
		params = i(4),
		ret = i(2, "return_type"),
		virtual = c(1, { t("virtual"), t("") }),
	}, {
		stored = {
			["return_type"] = i(nil, "void"),
		},
	})
end
ls.add_snippets("cpp", {
	s("funcsign", cpp_function_snippet()),
	s(
		"absclass",
		f(function(args, snip)
			-- print(vim.uri_to_fname(vim.uri_from_bufnr0))
			local env = snip.env
			print(env.TM_FILENAME_BASE)
			return {
				"#pragma once",
				"class C" .. env.TM_FILENAME_BASE,
				"{",
				"  public:",
				"    C" .. env.TM_FILENAME_BASE .. "();",
				"    ~C" .. env.TM_FILENAME_BASE .. "();",
				"};",
			}
		end, {})
	),
	s("inclabs", {
		t("#include "),
		i(1),
		t(""),
		t("typedef C"),
		rep(1),
		t(".h CAbs"),
		rep(1),
		t(".h"),
	}),
	s("ifwin", {
		t({ "#ifdef WIN32", "" }),
		i(1),
		t(""),
		t("#endif"),
	}),
	s("nifwin", {
		t({ "#ifndef WIN32", "" }),
		i(1),
		t({ "", "#endif" }),
	}),
	s("ifwinelse", {
		t({ "#ifdef WIN32", "" }),
		i(1),
		t({ "", "#else", "" }),
		i(2),
		t({ "", "#endif" }),
	}),
})

-- https://github.com/garcia5/dotfiles/blob/master/files/nvim/lua/ag/snippets/typescript.lua
local ts_function_fmt = [[
{doc}
{async}{name}({params}): {ret} {{
	{body}
}}
]]
local ts_function_snippet = function()
	return fmt(ts_function_fmt, {
		doc = isn(1, {
			t({ "/**", " " }),
			i(1, "function description"),
			c(2, {
				sn(nil, {
					t({ "", " @returns " }),
					i(1, "return description"),
				}),
				t(""),
			}),
			t({ "", "/" }),
		}, "$PARENT_INDENT *"),
		async = c(2, { t("async "), t("") }),
		name = i(3, "funcName"),
		params = i(4),
		ret = d(5, function(args)
			local async = string.match(args[1][1], "async")
			if async == nil then
				return sn(nil, {
					r(1, "return_type", i(nil, "void")),
				})
			end
			return sn(nil, {
				t("Promise<"),
				r(1, "return_type", i(nil, "void")),
				t(">"),
			})
		end, { 2 }),
		body = i(0),
	}, {
		stored = {
			["return_type"] = i(nil, "void"),
		},
	})
end

ls.add_snippets("typescript", {
	s("function", ts_function_snippet()),
})
