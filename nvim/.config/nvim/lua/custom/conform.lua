local conform = require "conform"

-- This method checks for if a config file for your formatter exists before
-- returning the formatters table or nil
---@return table

conform.setup {
  formatters_by_ft = {
    lua = { "stylua" },
    typescript = { "prettierd" },
    typescriptreact = { "prettierd" },
    javascript = { "prettierd" },
    svelte = { "prettierd" },
    json = { "prettierd" },
    markdown = { "prettierd" },
  },

  formatters = {
    prettierd = {
      require_cwd = true,
    },
  },

  format_on_save = {
    lsp_format = "never",
    quiet = true,
  },
}
