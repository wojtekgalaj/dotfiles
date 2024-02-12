local rest = require("rest-nvim")

rest.setup({
	result_split_in_place = true,
	result_split_horizontal = true,
})
vim.api.nvim_set_keymap("n", "<leader>rs", "<Plug>RestNvim", { noremap = true, silent = true })
