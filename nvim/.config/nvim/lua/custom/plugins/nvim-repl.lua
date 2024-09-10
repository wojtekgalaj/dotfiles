return {
  {
    "pappasam/nvim-repl",
    init = function()
      vim.g["repl_filetype_commands"] = {
        javascript = "node",
        svelte = "node",
      }
    end,
    keys = {
      { "<leader>rt", "<cmd>ReplToggle<cr>", desc = "Toggle nvim-repl" },
      { "<leader>rc", "<cmd>ReplRunCell<cr>", desc = "nvim-repl run cell" },
    },
  },
}
