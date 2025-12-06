return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-jest",
      "marilari88/neotest-vitest",
      "arthur944/neotest-bun",
      "thenbe/neotest-playwright",
    },
    config = function()
      ---@diagnostic disable-next-line:missing-fields
      require("neotest").setup {
        adapters = {
          require "neotest-jest" {
            jestCommand = "npm test --",
            jestConfigFile = "jest.config.js",
          },
          require "neotest-vitest" {
            filter_dir = function(name)
              return name ~= "node_modules"
            end,
          },
          require("neotest-playwright").adapter {
            options = {
              persist_project_selection = true,
              enable_dynamic_test_discovery = true,
            },
          },
        },
      }
    end,
  },
}
