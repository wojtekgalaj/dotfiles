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

local function toggle_center_screen()
	vim.api.nvim_command("VenterToggle")
end

vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = "*.md",
	desc = "Toggle Venter when entering a markdown buffer",
	callback = function()
		pcall(toggle_center_screen)
	end,
})

vim.api.nvim_create_autocmd({ "BufWinLeave" }, {
	pattern = { "*.md" },
	desc = "Toggle Venter when leaving a markdown buffer",
	callback = function()
		pcall(toggle_center_screen)
	end,
})
