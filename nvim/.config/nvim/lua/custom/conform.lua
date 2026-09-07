local conform = require "conform"

-- This method checks for if a config file for your formatter exists before
-- returning the formatters table or nil
---@return table

conform.setup {
  formatters_by_ft = {
    lua = { "stylua" },
    go = { "goimports", "gofumpt" },
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
    gofumpt = {
      prepend_args = { "-extra" },
    },
  },

  format_on_save = {
    lsp_format = "never",
    quiet = true,
  },
}
