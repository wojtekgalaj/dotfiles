-- nvim-cmp setup
local cmp = require("cmp")

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-a>"] = cmp.get_entries(),
		["<C-y>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		}),
	}),
	sources = {
		{ name = "cody" },
		{ name = "nvim_lsp" },
	},
	{
		name = "buffer",
	},
})
