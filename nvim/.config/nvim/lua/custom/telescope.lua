-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require("telescope").setup {
  defaults = {
    file_ignore_patterns = { "node_modules", ".git", "*-lock.json" },
    mappings = {
      i = {
        ["<C-u>"] = false,
        ["<C-d>"] = false,
      },
    },
    extensions = {},
  },
}

pcall(require("telescope").load_extension, "fzf")
vim.api.nvim_set_hl(0, "TelescopeBorder", { ctermbg = 220 })
