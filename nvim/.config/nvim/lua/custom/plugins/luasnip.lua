return {
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    config = function()
      local ls = require "luasnip"
      ls.config.set_config { history = true, updateevents = "TextChanged,TextChangedI" }
      vim.keymap.set({ "i", "s" }, "<C-j>", function()
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
        end
      end)
      vim.keymap.set({ "i", "s" }, "<C-k>", function()
        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      end)
      require("luasnip.loaders.from_lua").lazy_load {
        paths = { "~/.config/nvim/lua/snippets" },
      }
    end,
  },
}
