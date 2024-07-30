return {
  {
    "joeldotdias/jsdoc-switch.nvim",
    ft = { -- Add or remove filetypes from this section depending on your requirements
      "javascript",
      "javascriptreact",
    },
    config = function()
      require("jsdoc-switch").setup() -- setup() must be called to create default keymaps
    end,
  },
}
