local wk = require "which-key"
wk.setup {
  preset = "helix",
  plugins = {
    marks = false,
    presets = {
      operators = true,
      motions = true,
      text_objects = true,
      windows = false,
      nav = true,
      z = true,
      g = true,
    },
  },
  icons = {
    group = "󱉆 ",
    mappings = false,
  },
}
