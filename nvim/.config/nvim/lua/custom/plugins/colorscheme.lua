return {
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    integrations = {
      telescope = {
        enabled = true,
        style = "nvchad",
      },
    },
    config = function()
      vim.o.termguicolors = true
      vim.cmd.colorscheme "catppuccin"
    end,
  },
}
