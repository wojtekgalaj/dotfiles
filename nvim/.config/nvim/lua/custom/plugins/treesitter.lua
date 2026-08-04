return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    enabled = true,
    dependencies = {
      { "JoosepAlviste/nvim-ts-context-commentstring" },
      { "nvim-treesitter/nvim-treesitter-textobjects" },
    },
    build = ":TSUpdate",
    config = function()
      -- require "custom.treesitter"
    end,
  },
}
