return {
  {
    "ThePrimeagen/harpoon",
    enabled = false,
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require "harpoon"

      harpoon.setup {}

      vim.keymap.set("n", "<M-s>", function()
        print("wokd" .. vim.inspect(harpoon.list()))
        harpoon:list():add()
      end)

      vim.keymap.set("n", "<M-f>", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)

      vim.keymap.set("n", "<A-j>", function()
        harpoon:list():select(1)
      end)
      vim.keymap.set("n", "<A-k>", function()
        harpoon:list():select(2)
      end)
      vim.keymap.set("n", "<A-l>", function()
        harpoon:list():select(3)
      end)

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set("n", "<A-S-j>", function()
        harpoon:list():prev()
      end)
      vim.keymap.set("n", "<A-S-k>", function()
        harpoon:list():next()
      end)
    end,
  },
}
