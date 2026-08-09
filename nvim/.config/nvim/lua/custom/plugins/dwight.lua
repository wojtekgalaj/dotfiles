return {
  {
    "otaleghani/dwight.nvim",
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("dwight").setup {
        backend = "opencode",
      }
    end,
  },
}
