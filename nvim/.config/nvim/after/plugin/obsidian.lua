local obsidian = require("obsidian")

obsidian.setup({
	dir = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/wojteks_vault",
	completion = {
		nvim_cmp = true,
		min_chars = 2,
	},
})

local wk = require("which-key")

-- normal mode mappings
wk.register({
	["<leader>"] = {
		o = {
			name = "[O]bsidian",
			s = { "<cmd>ObsidianSearch<cr>", "Search" },
			b = { "<cmd>ObsidianBacklinks<cr>", "Backlinks" },
			c = { "<cmd>ObsidianCheck<cr>", "Check" },
			d = { "<cmd>ObsidianDailies<cr>", "Dailies" },
			e = { "<cmd>ObsidianExtractNote<cr>", "Extract note", mode = "v" },
		},
	},
}, { mode = "n", silent = true, noremap = true })

-- visual mode mappings
wk.register({
	["<leader>"] = {
		o = {
			name = "[O]bsidian",
			e = { "<cmd>ObsidianExtractNote<cr>", "Extract note", mode = "v" },
		},
	},
}, { mode = "v", silent = true, noremap = true })
