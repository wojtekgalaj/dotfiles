return {
  {
    "alexghergh/nvim-tmux-navigation",
    config = function()
      require("nvim-tmux-navigation").setup {}

      vim.keymap.set("n", "<C-h>", "<cmd>NvimTmuxNavigateLeft<cr>")
      vim.keymap.set("n", "<C-j>", "<cmd>NvimTmuxNavigateDown<cr>")
      vim.keymap.set("n", "<C-k>", "<cmd>NvimTmuxNavigateUp<cr>")
      vim.keymap.set("n", "<C-l>", "<cmd>NvimTmuxNavigateRight<cr>")
    end,
  },
}
