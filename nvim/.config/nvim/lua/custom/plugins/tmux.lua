return {
  {
    "aserowy/tmux.nvim",
    enabled = true,
    config = function()
      return require("tmux").setup {
        resize = {
          resize_step_x = 5,
          resize_step_y = 5,
        },
      }
    end,
  },
}
