return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects" },
      { "JoosepAlviste/nvim-ts-context-commentstring" },
      { "nvim-treesitter/nvim-tree-docs" },
    },
    build = ":TSUpdate",
    config = function()
      require "custom.treesitter"
    end,
  },
}
