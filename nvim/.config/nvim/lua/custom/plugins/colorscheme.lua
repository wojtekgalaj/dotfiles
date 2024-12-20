return {

  {
    "slugbyte/lackluster.nvim",
    lazy = false,
    priority = 1000,
    init = function()
      -- vim.cmd.colorscheme "lackluster"
      vim.cmd.colorscheme "lackluster-hack" -- my favorite
      -- vim.cmd.colorscheme("lackluster-mint")
    end,
  },

  -- {
  --   "mathofprimes/nightvision-nvim",
  --   lazy = false,
  --   priority = 1000,
  --   init = function()
  --     vim.cmd.colorscheme "nightvision"
  --     vim.g.nv_contrast = "soft"
  --   end,
  -- },

  -- {
  --   "olivercederborg/poimandres.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require("poimandres").setup {
  --       -- leave this setup function empty for default config
  --       -- or refer to the configuration section
  --       -- for configuration options
  --     }
  --   end,
  --
  --   -- optionally set the colorscheme within lazy config
  --   init = function()
  --     vim.cmd "colorscheme poimandres"
  --   end,
  -- },
}
