return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      "nvim-telescope/telescope.nvim", -- optional
    },
    config = function()
      require("neogit").setup {
        use_default_keymaps = true,
        graph_style = "unicode",
        mappings = {
          popup = {
            ["?"] = "HelpPopup",
            ["A"] = "CherryPickPopup",
            ["B"] = "BisectPopup",
            ["b"] = "BranchPopup",
            ["c"] = "CommitPopup",
            ["d"] = "DiffPopup",
            ["f"] = "FetchPopup",
            ["i"] = "IgnorePopup",
            ["l"] = "LogPopup",
            ["m"] = "MergePopup",
            ["M"] = "RemotePopup",
            ["P"] = "PullPopup",
            ["p"] = "PushPopup",
            ["r"] = "RebasePopup",
            ["t"] = "TagPopup",
            ["v"] = "RevertPopup",
            ["w"] = "WorktreePopup",
            ["x"] = "ResetPopup",
            ["z"] = "StashPopup",
          },
        },
      }
    end,
  },
}
