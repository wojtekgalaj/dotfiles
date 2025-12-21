return {
  {
    "NickvanDyke/opencode.nvim",
    dependencies = {
      -- Recommended for `ask()` and `select()`.
      -- Required for `snacks` provider.
    },
    config = function()
      ---@type opencode.Opts

      -- Required for `opts.events.reload`.
      vim.o.autoread = true
    end,
  },
}
