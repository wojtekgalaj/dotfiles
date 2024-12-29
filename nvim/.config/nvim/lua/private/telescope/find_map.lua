local M = {}

M.search = function()
  require("telescope.builtin").find_files {
    prompt_title = "Find File",
    cwd = vim.fn.expand "%:p:h",
  }
end
