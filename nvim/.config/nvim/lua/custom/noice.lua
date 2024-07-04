require("noice").setup {
  messages = {
    enabled = false,
  },
  lsp = {
    progress = {
      enabled = false,
    },
  },
  presets = {
    long_message_to_split = true,
  },
}
