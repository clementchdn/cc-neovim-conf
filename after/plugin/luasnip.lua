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
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

require("luasnip.loaders.from_vscode").load({ paths = "~/code-snippets/" })

ls.add_snippets("cpp", {
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
		t("#infdef WIN32"),
		i(1),
		t("#endif"),
	}),
	s("nifwin", {
		t("#infdef WIN32"),
		i(1),
		t("#endif"),
	}),
	s("ifwinelse", {
		t("#ifdef WIN32"),
		i(1),
		t("#else"),
		i(2),
		t("#endif"),
	}),
})
