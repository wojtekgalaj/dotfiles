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

      -- Setup the bindings
      local wk = require "which-key"
      wk.add {
        mode = "n",
        -- 'a' group is defined in plugin/keymaps.lua
        { "<leader>aa", "<cmd>Codeium Auth<cr>", desc = "Codeium [a]uth" },
        { "<leader>ac", "<cmd>Codeium Chat<cr>", desc = "Codeium [c]hat" },
        { "<leader>ct", "<cmd>Codeium Toggle<cr>", desc = "Codeium [t]oggle, enable/disable" },
      }
      vim.g.codeium_filetypes = {
        oil = false,
      }
    end,
  },
}
