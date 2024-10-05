return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "marilari88/neotest-vitest",
    },
    config = function()
      require("neotest").setup {
        adapters = {
          require "neotest-vitest" {
            filter_dir = function(dir)
              return dir ~= "node_modules"
            end,
          },
        },
      }

      vim.api.nvim_set_keymap(
        "n",
        "<leader>uwr",
        "<cmd>lua require('neotest').run.run({ vitestCommand = 'npm run unit:debug' })<cr>",
        { desc = "Run Watch" }
      )

      vim.api.nvim_set_keymap(
        "n",
        "<leader>uwf",
        "<cmd>lua require('neotest').run.run({ vim.fn.expand('%'), vitestCommand = 'npm run unit' })<cr>",
        { desc = "Run Watch File" }
      )
    end,
  },
}
