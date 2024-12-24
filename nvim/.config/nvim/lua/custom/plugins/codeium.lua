return {
  -- {
  --   "Exafunction/codeium.vim",
  --   config = function()
  --     -- Change '<C-g>' here to any keycode you like.
  --     vim.keymap.set("i", "<c-y>", function()
  --       return vim.fn["codeium#Accept"]()
  --     end, { expr = true, silent = true })
  --     vim.keymap.set("i", "<c-n>", function()
  --       return vim.fn["codeium#CycleCompletions"](1)
  --     end, { expr = true, silent = true })
  --     vim.keymap.set("i", "<c-p>", function()
  --       return vim.fn["codeium#CycleCompletions"](-1)
  --     end, { expr = true, silent = true })
  --     vim.keymap.set("i", "<c-k>", function()
  --       return vim.fn["codeium#Clear"]()
  --     end, { expr = true, silent = true })
  --
  --     -- Setup the bindings
  --     vim.g.codeium_filetypes = {
  --       oil = false,
  --     }
  --   end,
  -- },
  {
    "Exafunction/codeium.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup {
        enable_cmp_source = true,
        virtual_text = {
          enabled = true,
        },
        nvim_cmp = {
          enabled = false,
        },
      }
    end,
  },
}
