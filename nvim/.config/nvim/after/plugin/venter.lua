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

local function silent_venter_open()
	local window_width = vim.api.nvim_win_get_width(0)
	if window_width > 120 then
		vim.api.nvim_command("Venter")
	end
end

local function silent_venter_close()
	vim.api.nvim_command("VenterClose")
end

local venter_autogroup = vim.api.nvim_create_augroup("venter_autogroup", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = "*.md",
	desc = "Toggle Venter when entering a markdown buffer",
	callback = function()
		pcall(silent_venter_open)
	end,
	group = venter_autogroup,
})

vim.api.nvim_create_autocmd({ "BufWinLeave" }, {
	pattern = { "*.md" },
	desc = "Toggle Venter when leaving a markdown buffer",
	callback = function()
		pcall(silent_venter_close)
	end,
	group = venter_autogroup,
})
