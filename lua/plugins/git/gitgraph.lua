return {
	"isakbm/gitgraph.nvim",
	dependencies = { "sindrets/diffview.nvim" },
	opts = {
		symbols = {
			merge_commit = "", -- nf-dev-git_merge
			commit = "●", -- standard unicode dot
			merge_commit_end = "", -- nf-dev-git_branch
			commit_end = "◆", -- standard unicode diamond

			-- Advanced symbols
			GVER = "│", -- branch symbol (nf-oct-git_branch)
			GHOR = "─", -- horizontal line
			GCLD = "╮", -- corner lower-left
			GCRD = "╰", -- corner upper-right
			GCLU = "╯", -- corner upper-left
			GCRU = "╭", -- corner lower-right
			GLRU = "┘", -- box-drawing corner
			GLRD = "┐", -- box-drawing corner
			GLUD = "│", -- vertical line
			GRUD = "│", -- vertical line
			GFORKU = "┴", -- T-shape up
			GFORKD = "┬", -- T-shape down
			GRUDCD = "┼", -- cross
			GRUDCU = "┼", -- cross
			GLUDCD = "┼", -- cross
			GLUDCU = "┼", -- cross
			GLRDCL = "┐", -- same as GLRD
			GLRDCR = "┤", -- right T
			GLRUCL = "┘", -- same as GLRU
			GLRUCR = "├", -- left T
		},
		format = {
			timestamp = "%H:%M:%S %d-%m-%Y",
			fields = { "hash", "timestamp", "author", "branch_name", "tag" },
		},
		hooks = {
			-- Check diff of a commit
			on_select_commit = function(commit)
				vim.notify("DiffviewOpen " .. commit.hash .. "^!")
				vim.cmd(":DiffviewOpen " .. commit.hash .. "^!")
			end,
			-- Check diff from commit a -> commit b
			on_select_range_commit = function(from, to)
				vim.notify("DiffviewOpen " .. from.hash .. "~1.." .. to.hash)
				vim.cmd(":DiffviewOpen " .. from.hash .. "~1.." .. to.hash)
			end,
		},
	},
	keys = {
		{
			"<leader>gl",
			function()
				require("gitgraph").draw({}, { all = true, max_count = 5000 })
			end,
			desc = "GitGraph - Draw",
		},
	},
}
