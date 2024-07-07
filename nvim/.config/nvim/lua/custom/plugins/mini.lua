return {
  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.ai").setup {}
      require("mini.surround").setup {}
      require("mini.jump2d").setup()
      require("mini.comment").setup {}
      require("mini.statusline").setup {}
      require("mini.pairs").setup {}
    end,
  },
}
