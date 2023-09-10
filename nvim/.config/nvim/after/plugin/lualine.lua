print("lua line loaded in the after folder")
require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "onedark",
		component_separators = "|",
		section_separators = "",
	},
})
