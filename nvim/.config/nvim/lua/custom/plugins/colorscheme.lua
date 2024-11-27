return {
  -- START CATPPUCCIN
  -- {
  --   "catppuccin/nvim",
  --   lazy = false,
  --   priority = 1000,
  --   integrations = {
  --     telescope = {
  --       enabled = true,
  --       style = "nvchad",
  --     },
  --   },
  --   config = function()
  --     vim.o.termguicolors = true
  --     vim.cmd.colorscheme "catppuccin"
  --   end,
  -- },
  -- END CATPPUCCIN

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
