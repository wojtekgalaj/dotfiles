-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  callback = function()
    vim.opt_local.scrolloff = 6
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "*.sh", "bash", "*.zsh", "*.fish", "*.ksh", "sketchybarrc" },
  callback = function()
    vim.lsp.start {
      name = "bash-language-server",
      cmd = { "bash-language-server", "start" },
    }
  end,
})
