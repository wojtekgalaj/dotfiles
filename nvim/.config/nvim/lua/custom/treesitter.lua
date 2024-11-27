local c = require "nvim-treesitter.configs"
c.setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = {
    "bash",
    "http",
    "go",
    "lua",
    "luadoc",
    "javascript",
    "sql",
    "typescript",
    "ninja",
    "svelte",
    "graphql",
    "css",
    "scss",
    "csv",
    "dockerfile",
    "html",
    "json",
    "markdown",
    "hurl",
  },

  sync_install = true,
  ignore_install = { "javascript" },
  auto_install = true,
  highlight = { enable = true },
  indent = { enable = true, disable = { "python" } },
  tree_docs = { enable = true },
  incremental_selection = {
    enable = true,
  },
  textobjects = {
    enable = true,
  },
}

local opt = vim.opt

opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 5
