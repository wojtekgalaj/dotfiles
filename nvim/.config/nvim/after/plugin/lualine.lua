require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "catppuccin",
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = {
			{
				"filename",
				file_status = false, -- displays file status (readonly status, modified status)
				path = 2, -- 0 = just filename, 1 = relative path, 2 = absolute path
			},
		},
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
})

-- The old theme was onedark
