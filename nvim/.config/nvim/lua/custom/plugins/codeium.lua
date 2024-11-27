return {
  {
    "Exafunction/codeium.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup {
        virtual_text = { enable = true },
      }

      local wk = require "which-key"
      wk.add {
        mode = "n",
        { "<leader>c", group = "[c]ode" },
        { "<leader>cc", "<cmd>Codeium Chat<cr>", desc = "Codeium [c]hat" },
      }
    end,
  },
}
