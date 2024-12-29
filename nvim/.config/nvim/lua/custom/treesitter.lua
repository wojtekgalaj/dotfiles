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

local parsers_config = require("nvim-treesitter.parsers").get_parser_configs()
-- Register this parser manually to nvim-treesitter's parser directory
parsers_config.ghostty = {
  install_info = {
    url = "https://github.com/bezhermoso/tree-sitter-ghostty",
    files = { "src/parser.c" },
    branch = "main",
    requires_generate_from_grammar = true,
  },
}
