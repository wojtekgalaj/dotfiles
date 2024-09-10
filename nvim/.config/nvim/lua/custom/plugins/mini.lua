return {
  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.ai").setup {}
      require("mini.surround").setup {}
      require("mini.jump2d").setup()
      require("mini.icons").setup {}
      require("mini.indentscope").setup {
        lazy = true,
        options = {
          indent_at_cursor = false,
        },
      }
      require("mini.comment").setup {
        options = {
          custom_commentstring = function()
            -- disabling default autocmd so treesitter can figure out the
            -- correct comment.
            -- https://github.com/JoosepAlviste/nvim-ts-context-commentstring/wiki/Integrations#plugins-with-a-pre-comment-hook
            local tcc = require "ts_context_commentstring"
            tcc.setup {
              enable_autocmd = false,
            }
            -- return the commentstring that nvim-treesitter is using
            return tcc.calculate_commentstring() or vim.bo.commentstring
          end,
        },
      }
      require("mini.statusline").setup {}
    end,
  },
}
