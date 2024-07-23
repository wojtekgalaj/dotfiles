return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    dependencies = {
      { "JoosepAlviste/nvim-ts-context-commentstring" },
      { "nvim-treesitter/nvim-treesitter-textobjects" },
      { "nvim-treesitter/nvim-treesitter-context", config = {
        mode = "topline",
      } },
      { "nvim-treesitter/nvim-tree-docs" },
    },
    build = ":TSUpdate",
    config = function()
      require "custom.treesitter"
    end,
  },
}
