-- return {
--   {
--     "Exafunction/codeium.nvim",
--     dependencies = {
--       "nvim-lua/plenary.nvim",
--       "hrsh7th/nvim-cmp",
--     },
--     config = function()
--       require("codeium").setup {
--         virtual_text = { enable = true },
--       }
--
--       local wk = require "which-key"
--       wk.add {
--         mode = "n",
--         { "<leader>c", group = "[c]ode" },
--         { "<leader>cc", "<cmd>Codeium Chat<cr>", desc = "Codeium [c]hat" },
--       }
--     end,
--   },
-- }-- Remove the `use` here if you're using folke/lazy.nvim.
return {
  {
    "Exafunction/codeium.vim",
    config = function()
      -- Change '<C-g>' here to any keycode you like.
      vim.keymap.set("i", "<c-y>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<c-n>", function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<c-p>", function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<c-k>", function()
        return vim.fn["codeium#Clear"]()
      end, { expr = true, silent = true })
    end,
  },
}
