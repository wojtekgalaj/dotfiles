return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
        -- used for completion, annotations and signatures of Neovim apis
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            -- Load luvit types when the `vim.uv` word is found
            { path = "luvit-meta/library", words = { "vim%.uv" } },
          },
        },
      },
      { "Bilal2453/luvit-meta", lazy = true },
      { "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },
      "saghen/blink.cmp",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      -- Autoformatting
      "stevearc/conform.nvim",
      -- Schema information
      "b0o/SchemaStore.nvim",
      -- Diagnostics for all the project
      "artemave/workspace-diagnostics.nvim",
    },
    config = function()
      require "custom.lsp"
    end,
  },
}
