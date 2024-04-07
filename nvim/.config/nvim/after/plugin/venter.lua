local wk = require("which-key")

wk.register({
	["<leader>"] = {
		t = {
			name = "[T]oggle",
			s = { "<cmd>VenterToggle<cr>", "[T]oggle center [S]creen" },
		},
	},
}, {
	mode = "n",
	silent = true,
	noremap = true,
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = "*.md",
	callback = function()
		vim.api.nvim_command("Venter")
	end,
})
