return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-jest",
    },
    config = function()
      require("neotest").setup {
        discovery = {
          enabled = true,
          extension = { "ts", "tsx", "js", "jsx", "json", "css", "scss", "html" },
        },
        adapters = {
          require "neotest-jest" {
            discovery = {
              enabled = true,
            },
            jestCommand = "yarn test --",
            jestConfigFile = function(file)
              if string.find(file, "/packages/") then
                return string.match(file, "(.-/[^/]+/)src") .. "jest.config.ts"
              end

              return vim.fn.getcwd() .. "/jest.config.ts"
            end,
            env = { CI = true },
            cwd = function(path)
              return vim.fn.getcwd()
            end,
          },
          require "neotest-jest" {
            discovery = {
              enabled = true,
            },
            jestCommand = "backstage-cli test --",
            jestConfigFile = function(file)
              -- No need to specify a jest config file as backstage-cli handles it
              return nil
            end,
            env = { CI = true },
            cwd = function(path)
              return vim.fn.getcwd()
            end,
          },
        },
      }
    end,
  },
}
