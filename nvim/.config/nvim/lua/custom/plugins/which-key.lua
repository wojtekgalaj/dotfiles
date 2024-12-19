return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require "custom.which_key"
    end,
  },
}
