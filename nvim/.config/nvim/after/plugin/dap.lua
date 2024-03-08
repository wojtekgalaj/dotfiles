local dap = require("dap")

dap.adapters.lldb = {
	type = "executable",
	command = "/opt/homebrew/bin/lldb-vscode", -- adjust as needed
	name = "lldb",
}

local lldb = {
	name = "Launch lldb",
	type = "lldb", -- matches the adapter
	request = "launch", -- could also attach to a currently running process
	program = function()
		return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
	end,
	cwd = "${workspaceFolder}",
	stopOnEntry = false,
	args = {},
	runInTerminal = false,
}

dap.configurations.rust = {
	lldb, -- different debuggers or more configurations can be used here
}

-- Configure the node2 debugger
dap.adapters.node2 = {
	type = "executable",
	command = "node",
	args = { os.getenv("HOME") .. "/.npm-packages/bin/node_modules/vscode-node-debug2/out/src/nodeDebug.js" },
}

-- Set the configuration for the debug session
dap.configurations.javascript = {
	{
		type = "node2",
		request = "launch",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		console = "integratedTerminal",
	},
}

dap.configurations.typescript = {
	{
		type = "node2",
		request = "launch",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		console = "integratedTerminal",
	},
}

-- Start debugging
vim.api.nvim_set_keymap("n", "<leader>dd", '<cmd>lua require("dap").continue()<CR>', { noremap = true, silent = true })
-- Stop debugging
vim.api.nvim_set_keymap(
	"n",
	"<leader>ds",
	'<cmd>lua require("dap").disconnect()<CR>',
	{ noremap = true, silent = true }
)
-- Toggle breakpoint
vim.api.nvim_set_keymap(
	"n",
	"<leader>db",
	'<cmd>lua require("dap").toggle_breakpoint()<CR>',
	{ noremap = true, silent = true }
)
