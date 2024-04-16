-- nvim-cmp setup
local cmp = require("cmp")

cmp.setup({
	snippet = {
		expand = function() end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-a>"] = cmp.get_entries(),
		["<C-y>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
	}),
	sources = {
		{ name = "cody" },
		{ name = "nvim_lsp" },
		{ name = "emmet_vim" },
	},
})
