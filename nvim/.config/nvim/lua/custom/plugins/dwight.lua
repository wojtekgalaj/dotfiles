return {
  {
    "otaleghani/dwight.nvim",
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("dwight").setup {
        backend = "opencode",
      }
    end,
  },
}
