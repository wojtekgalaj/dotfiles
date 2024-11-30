vim.api.nvim_create_autocmd("BufWinEnter", {
  callback = function()
    vim.cmd "wincmd L"
  end,
})
