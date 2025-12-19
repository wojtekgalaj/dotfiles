return {
  {
    "NickvanDyke/opencode.nvim",
    dependencies = {
      -- Recommended for `ask()` and `select()`.
      -- Required for `snacks` provider.
    },
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        -- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
        provider = {
          enabled = "tmux",
        },
      }

      -- Required for `opts.events.reload`.
      vim.o.autoread = true
    end,
  },
}
