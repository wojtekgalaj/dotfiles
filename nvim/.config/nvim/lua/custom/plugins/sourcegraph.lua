return {
  {
    "sourcegraph/sg.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    lazy = true,
    build = "nvim -l build/init.lua",
    config = function()
      -- require "custom.sourcegraph"
    end,
  },
}
