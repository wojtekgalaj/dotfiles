local oil = require("oil")

oil.setup({
	use_default_keymaps = false,
	keymaps = {
		["g?"] = "actions.show_help",
		["<CR>"] = "actions.select",
		["<C-p>"] = "actions.preview",
		["<C-c>"] = "actions.close",
		["-"] = "actions.parent",
		["g."] = "actions.toggle_hidden",
	},
	view_options = {
		show_hidden = true,
	},
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { silent = true, desc = "Open parent directory" })
