return {
  {
    "yochem/jq-playground.nvim",
    config = function()
      require("jq-playground").setup {
        query_window = {
          scratch = true,
          name = "jq_query",
        },
      }
    end,
  },
}
