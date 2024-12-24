return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    dependencies = { "justinsgithub/wezterm-types" },
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
        { "neotest" },
        { "lazy.nvim" },
        { path = "wezterm-types", mods = { "wezterm" } },
      },
    },
  },
  {
    "saghen/blink.compat",
    -- use the latest release, via version = '*', if you also use the latest release for blink.cmp
    version = "*",
    -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
    lazy = true,
    -- make sure to set opts so that lazy.nvim calls blink.compat's setup
    opts = {
      impersonate_nvim_cmp = true,
    },
  },
  { -- optional blink completion source for require statements and module annotations
    "saghen/blink.cmp",
    opts = {
      sources = {
        -- add lazydev to your completion providers
        default = { "codeium", "lazydev", "lsp" },
        providers = {
          codeium = {
            name = "Codeium",
            module = "blink.compat.source",
            score_offset = 90,
          },
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
        },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
  { "folke/neodev.nvim", enabled = false }, -- make sure to uninstall or disable neodev.nvim
}
