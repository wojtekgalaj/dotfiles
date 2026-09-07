-- Go buffer defaults (tabs, as gofmt expects)
vim.bo.expandtab = false
vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.bo.softtabstop = 4

-- Works before gopls attaches; LspAttach remaps K to the same handler.
vim.keymap.set("n", "K", function()
  require("custom.go_hover").hover()
end, { buffer = true, desc = "Hover documentation" })
