return {
  -- {
  --   "MeanderingProgrammer/render-markdown.nvim",
  --   config = function()
  --     require("render-markdown").setup {
  --       heading = { sign = false },
  --     }
  --   end,
  --   dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
  -- },
  {
    "OXY2DEV/markview.nvim",
    lazy = false, -- Recommended
    -- ft = "markdown" -- If you decide to lazy-load anyway

    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
}
