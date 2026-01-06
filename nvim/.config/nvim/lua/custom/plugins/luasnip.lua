return {
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    config = function()
      local path_to_snippets = vim.fn.stdpath "config" .. "/snippets"
      print("loading lua snippets in the config and the path is" .. path_to_snippets)
      require("luasnip.loaders.from_lua").load { paths = path_to_snippets }
    end,
  },
}
