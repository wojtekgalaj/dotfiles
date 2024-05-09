-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require("nvim-treesitter.configs").setup({
	-- Add languages to be installed here that you want installed for treesitter
	ensure_installed = {
		"bash",
		"http",
		"go",
		"lua",
		"javascript",
		"typescript",
		"help",
		"ninja",
		"svelte",
		"html",
		"json",
		"markdown",
		"hurl",
	},

	sync_install = true,
	ignore_install = { "javascript" },
	auto_install = true,

	highlight = { enable = true },
	indent = { enable = true, disable = { "python" } },
	incremental_selection = {
		enable = true,
	},
	modules = {},
	textobjects = {
		enable = true,
	},
})
