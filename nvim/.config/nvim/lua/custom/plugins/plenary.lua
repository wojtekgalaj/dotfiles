return {
  {
    "nvim-lua/plenary.nvim",
    config = function()
      local amazon_q = require "custom.amazon_q"
      amazon_q.setup()
    end,
  },
}
