---@module enables navigating between vim panes and multiplexer panes
return {
  {
    "numToStr/Navigator.nvim",
    config = function()
      require("Navigator").setup {}
    end,
  },
}
