pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "media_files")
pcall(require("telescope").load_extension, "frecency")
pcall(require("telescope").load_extension, "node_modules")
vim.api.nvim_set_hl(0, "TelescopeBorder", { ctermbg = 220 })

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require("telescope").setup {
  pickers = {
    find_files = {
      theme = "ivy",
    },
    grep_string = {
      theme = "ivy",
    },
    live_grep = {
      theme = "ivy",
    },
    buffers = {
      theme = "ivy",
    },
  },
  defaults = {
    prompt_prefix = "   > ",
    file_ignore_patterns = { "node_modules", ".git", "*-lock.json", "yarn.lock", "dist" },
    mappings = {
      i = {
        ["<C-u>"] = false,
        ["<C-d>"] = false,
      },
    },
  },
  extensions = {
    media_files = {
      filetypes = { "png", "webp", "jpg", "jpeg" },
    },
  },
}
