return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup {
        current_line_blame = false,
        on_attach = function(bufnr)
          local gitsigns = require "gitsigns"

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map("n", "]c", function()
            if vim.wo.diff then
              vim.cmd.normal { "]c", bang = true }
            else
              gitsigns.nav_hunk "next"
            end
          end)

          map("n", "[c", function()
            if vim.wo.diff then
              vim.cmd.normal { "[c", bang = true }
            else
              gitsigns.nav_hunk "prev"
            end
          end)

          -- Actions
          map("n", "<leader>gs", gitsigns.stage_hunk, { desc = "[s]tage hunk" })
          map("n", "<leader>gr", gitsigns.reset_hunk, { desc = "[r]eset hunk" })
          map("v", "<leader>gs", function()
            gitsigns.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
          end, { desc = "[s]tage visual hunk" })
          map("v", "<leader>gr", function()
            gitsigns.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
          end, { desc = "[r]eset visual hunk" })
          map("n", "<leader>gS", gitsigns.stage_buffer, { desc = "[S]tage buffer" })
          map("n", "<leader>gu", gitsigns.undo_stage_hunk, { desc = "Undo stage hunk" })
          map("n", "<leader>tB", gitsigns.toggle_current_line_blame, { desc = "Toggle current line [B]lame" })
          map("n", "<leader>gR", gitsigns.reset_buffer, { desc = "Reset buffer" })
          map("n", "<leader>gp", gitsigns.preview_hunk, { desc = "Preview hunk" })
          map("n", "<leader>gd", gitsigns.diffthis, { desc = "Diff this file" })
          map("n", "<leader>gD", function()
            gitsigns.diffthis "~"
          end, { desc = "Diff against HEAD" })
          map("n", "<leader>gx", gitsigns.toggle_deleted, { desc = "Toggle deleted" })
        end,
      }
    end,
  },
}
