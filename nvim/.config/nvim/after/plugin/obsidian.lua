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
			s = { "<cmd>ObsidianSearch<cr>", "[S]earch" },
			o = { "<cmd>ObsidianQuickSwitch<cr>", "[O]pen" },
			c = { "<cmd>ObsidianCheck<cr>", "[C]heck" },
			d = { "<cmd>ObsidianDailies<cr>", "[D]ailies" },
			n = { "<cmd>ObsidianNew<cr>", "[N]ew" },
			t = { "<cmd>ObsidianTags<cr>", "[T]ags" },
			l = {
				name = "[L]ink",
				l = { "<cmd>ObsidianFollowLink<cr>", "Follow [L]ink" },
				b = { "<cmd>ObsidianBacklinks<cr>", "[B]acklinks" },
				n = { "<cmd>ObsidianLinkNew<cr>", "[N]ew note and link" },
			},
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
