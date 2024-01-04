require("sg").setup({})

vim.keymap.set("n", "<leader>cc", function()
	require("sg.extensions.telescope").fuzzy_search_results()
end, { silent = true, noremap = true, desc = "[S]earch [S]ourcemap" })

-- You can call this function from Neovim command-line or in another Lua function

local function cody_ask_range()
	local bufnr = vim.api.nvim_get_current_buf()

	-- Get the start and end row numbers of the visual selection using marks '< and '>
	local _, line_start = unpack(vim.fn.getpos("v"))
	local _, line_end = unpack(vim.fn.getpos("."))

	local commands = require("sg.cody.commands")
	local msg = vim.fn.input("Ask cody about the selection: ") or "Explain this code: "

	commands.ask_range(bufnr, line_start, line_end, msg)
end
vim.keymap.set("v", "<leader>ar", cody_ask_range, { silent = true, noremap = true, desc = "[A]sk [R]ange" })

local function cody_ask()
	local commands = require("sg.cody.commands")
	local msg = vim.fn.input("Ask cody anything: ")

	commands.ask(msg)
end
vim.keymap.set("n", "<leader>aa", cody_ask, { silent = true, noremap = true, desc = "[A]sk [A]nything" })
