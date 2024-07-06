require("noice").setup {
  lsp = {
    progress = {
      enabled = false,
    },
    hover = {
      silent = true,
    },
  },
  presets = {
    long_message_to_split = true,
    lsp_doc_border = true,
  },
}

vim.keymap.set({ "n", "i", "s" }, "<c-f>", function()
  if not require("noice.lsp").scroll(4) then
    return "<c-f>"
  end
end, { silent = true, expr = true })

vim.keymap.set({ "n", "i", "s" }, "<c-b>", function()
  if not require("noice.lsp").scroll(-4) then
    return "<c-b>"
  end
end, { silent = true, expr = true })
