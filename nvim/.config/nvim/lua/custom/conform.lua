local conform = require "conform"

-- This method checks for if a config file for your formatter exists before
-- returning the formatters table or nil
---@return table
local use_these_if_prettierrc_found = function()
  local prettierrc_exists = vim.fn.findfile(".prettierrc", ".;")
  local prettierrc_json_exists = vim.fn.findfile(".prettierrc.json", ".;")
  local prettierrc_js_exists = vim.fn.findfile(".prettierrc.js", ".;")
  if prettierrc_exists or prettierrc_json_exists or prettierrc_js_exists then
    return { "prettierd", "prettier" }
  else
    return {}
  end
end

conform.setup {
  formatters_by_ft = {
    lua = { "stylua" },
    typescript = use_these_if_prettierrc_found(),
    typescriptreact = use_these_if_prettierrc_found(),
    javascript = use_these_if_prettierrc_found(),
    svelte = use_these_if_prettierrc_found(),
    json = use_these_if_prettierrc_found(),
    markdown = use_these_if_prettierrc_found(),
  },
  format_on_save = {
    lsp_format = "never",
    quiet = true,
  },
}
