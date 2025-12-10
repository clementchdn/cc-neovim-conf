local home = os.getenv("HOME")
local workspace_path = home .. "/.local/share/nvim/jdtls-workspace/"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = workspace_path .. project_name

local status, jdtls = pcall(require, "jdtls")
if not status then
	return
end
local extendedClientCapabilities = jdtls.extendedClientCapabilities

local config = {
	cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-javaagent:" .. home .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar",
		"-jar",
		vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
		"-configuration",
		home .. "/.local/share/nvim/mason/packages/jdtls/config_linux",
		"-data",
		workspace_dir,
	},
	root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),

	settings = {
		java = {
			signatureHelp = { enabled = true },
			extendedClientCapabilities = extendedClientCapabilities,
			maven = {
				downloadSources = true,
			},
			referencesCodeLens = {
				enabled = true,
			},
			references = {
				includeDecompiledSources = true,
			},
			inlayHints = {
				parameterNames = {
					enabled = "all", -- literals, all, none
				},
			},
			format = {
				enabled = false,
			},
		},
	},

	init_options = {
		bundles = {},
	},
}

local mason_packages_path = vim.fn.stdpath("data") .. "/mason/packages"

local bundles = {
	mason_packages_path .. "/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-0.53.2.jar",
}

local test_path = mason_packages_path .. "/java-test/extension/server"

local test_jars = vim.split(vim.fn.glob(test_path .. "/*.jar"), "\n")

local excluded = {
	"com.microsoft.java.test.runner-jar-with-dependencies.jar",
	"jacocoagent.jar",
}

for _, jar in ipairs(test_jars) do
	local fname = vim.fn.fnamemodify(jar, ":t")
	if not vim.tbl_contains(excluded, fname) then
		table.insert(bundles, jar)
	end
end

config.init_options = {
	bundles = bundles,
}

require("jdtls").start_or_attach(config)

local jdtls = require("jdtls")

vim.api.nvim_create_user_command("OrganizeImports", function()
	jdtls.organize_imports()
end, {})

vim.api.nvim_create_user_command("ExtractVariable", function()
	jdtls.extract_variable()
end, {})

vim.api.nvim_create_user_command("ExtractVariableVisual", function()
	jdtls.extract_variable(true)
end, {})

vim.api.nvim_create_user_command("ExtractConstant", function()
	jdtls.extract_constant()
end, {})

vim.api.nvim_create_user_command("ExtractConstantVisual", function()
	jdtls.extract_constant(true)
end, {})

vim.api.nvim_create_user_command("ExtractMethod", function()
	jdtls.extract_method(true)
end, {})

vim.api.nvim_create_user_command("TestClass", function()
	jdtls.test_class()
end, {})

vim.api.nvim_create_user_command("TestMethod", function()
	jdtls.test_nearest_method()
end, {})
