return {
  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.ai").setup {}
      require("mini.jump2d").setup()
      require("mini.icons").setup {}
      require("mini.pairs").setup {}
      require("mini.indentscope").setup {
        lazy = true,
        options = {
          indent_at_cursor = false,
        },
      }
      require("mini.comment").setup {}
      require("custom.statusline").setup {}
    end,
  },
}
