local wk = require "which-key"
wk.setup {
  preset = "helix",
  notify = true,
  plugins = {
    marks = false,
    presets = {
      operators = true,
      motions = true,
      text_objects = true,
      windows = true,
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
