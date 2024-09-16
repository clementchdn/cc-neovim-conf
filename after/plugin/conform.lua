local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		c = { "clang-format" },
		cpp = { "clang-format" },
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		python = { "isort", "black" },
		-- Use a sub-list to run only the first available formatter
		javascript = { { "prettierd", "prettier" } },
		typescript = { { "prettierd", "prettier" } },
		javascriptreact = { { "prettierd", "prettier" } },
		typescriptreact = { { "prettierd", "prettier" } },
		html = { { "prettierd", "prettier" } },
		vue = { { "prettierd", "prettier" } },
		-- cpp = { "clangd" },
		-- c = { "clangd" },
		-- hpp = { "clang-format" },
		-- h = { "clang-format" },
		format_on_save = {
			lsp_fallback = true,
			async = false,
			timeout_ms = 1000,
		},
	},
	default_format_opts = {
		timeout_ms = 10000,
	},
})

conform.formatters.black = {
	prepend_args = { "--line-length=140" },
}

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		conform.format({ bufnr = args.buf })
	end,
})
-- vim.keymap.set("n", "<leader>f", conform.format({bufnr = 0}))
