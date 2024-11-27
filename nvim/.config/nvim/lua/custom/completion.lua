-- vim.opt.completeopt = { "menu", "menuone", "noselect" }
-- vim.opt.shortmess:append "c"

local cmp = require "cmp"
cmp.setup {
  sources = {
    { name = "codeium" },
    { name = "luasnip" },
    { name = "nvim_lsp" },
    { name = "path" },
  },
  mapping = cmp.mapping.preset.insert {
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-a>"] = cmp.get_entries(),
    ["<C-y>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  formatting = {
    format = require("lspkind").cmp_format {
      mode = "symbol",
      maxwidth = 50,
      ellipsis_char = "...",
      symbol_map = { Codeium = "AI" },
    },
  },
}

local ls = require "luasnip"

ls.config.set_config {
  history = false,
  updateevents = "TextChanged,TextChangedI",
}

for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/custom/snippets/*.lua", true)) do
  loadfile(ft_path)()
end

vim.keymap.set({ "i", "s" }, "<c-k>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<c-j>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })
