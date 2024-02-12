local wk = require("which-key")

wk.register({
	["<leader>"] = {
		c = {
			name = "[C]enter",
			s = { "<cmd>VenterToggle<cr>", "[C]enter [S]creen" },
		},
	},
}, {
	mode = "n",
	silent = true,
	noremap = true,
})
