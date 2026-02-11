---@param issue table
---@return string[]
local function format_issue(issue)
	local fields = issue.fields or {}

	-- Safely get assignee's short name or blank
	local assignee = ""
	local assignee_obj = fields.assignee
	if assignee_obj and assignee_obj ~= vim.NIL and assignee_obj.displayName then
		local i, j = string.find(assignee_obj.displayName, "%w+")
		if i and j then
			assignee = " - @" .. string.sub(assignee_obj.displayName, i, j)
		else
			assignee = " - @" .. assignee_obj.displayName
		end
	end

	-- Safely get status
	local status = (fields.status and fields.status.name) or ""

	-- Safely get description
	local description_content = ""
	if fields.description and fields.description ~= vim.NIL then
		description_content = fields.description
	end

	local summary = fields.summary or "No summary"
	local project = fields.project and fields.project.name or ""
	local priority = fields.priority and fields.priority.name or ""
	local labels = not vim.tbl_isempty(fields.labels or {}) and table.concat(fields.labels, ",") or "None"
	local created = fields.created or ""
	local updated = fields.updated or ""

	local content = {
		"# " .. summary,
		"",
		"**Project:** " .. project,
		"**Status:** `" .. status .. "`" .. assignee,
		"**Priority:** " .. priority,
		"**Labels:** " .. labels,
		"**Created:** " .. created,
		"**Updated:** " .. updated,
		"",
		"----",
		"",
		description_content or "",
		"",
	}

	-- Optionally, show worklogs
	if fields.worklog and not vim.tbl_isempty(fields.worklog.worklogs or {}) then
		table.insert(content, "### Worklog:")
		for _, log in ipairs(fields.worklog.worklogs) do
			table.insert(
				content,
				string.format("- %s: %s (%s)", log.author.displayName, log.comment or "", log.started or "")
			)
		end
	end
	return content
end

return {
	"Funk66/jira.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("jira").setup({
			api_version = 2,
			auth_type = "Bearer",
			domain = vim.env.JIRA_DOMAIN,
			user = vim.env.JIRA_USER,
			token = vim.env.JIRA_API_TOKEN,
			key = vim.env.JIRA_PROJECT_KEY,
			format = format_issue,
		})
	end,
	cmd = {
		"JiraView",
		"JiraOpen",
	},
	cond = function()
		return vim.env.JIRA_API_TOKEN ~= nil
	end,
	keys = {
		{ "<leader>jv", ":JiraView<cr>", desc = "View Jira issue", silent = true },
		{ "<leader>jo", ":JiraOpen<cr>", desc = "Open Jira issue in browser", silent = true },
	},
}
