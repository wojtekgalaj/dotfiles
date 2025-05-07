return {
  {
    "rockerBOO/boo-colorscheme-nvim",
    enabled = false,

    lazy = false,
    priority = 1000,
    init = function()
      require("boo-colorscheme").use {
        italic = false,
        theme = "sunset_cloud",
      }
    end,
  },
  {
    "slugbyte/lackluster.nvim",
    enabled = true,

    lazy = false,
    priority = 1000,
    init = function()
      -- vim.cmd.colorscheme "lackluster"
      vim.cmd.colorscheme "lackluster-hack" -- my favorite
      -- vim.cmd.colorscheme("lackluster-mint")
    end,
  },
  {
    "everviolet/nvim",
    name = "evergarden",
    priority = 1000, -- Colorscheme plugin is loaded first before any other plugins
    enabled = false,
    opts = {
      theme = {
        variant = "fall", -- 'winter'|'fall'|'spring'|'summer'
        accent = "green",
      },
      editor = {
        transparent_background = false,
        sign = { color = "none" },
        float = {
          color = "mantle",
          invert_border = false,
        },
        completion = {
          color = "surface0",
        },
      },
    },
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
