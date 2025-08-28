-- This plugin is the one to use when searching for nerdfont glyphs
return {
  -- Lazy
  {
    "2kabhishek/nerdy.nvim",
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = "Nerdy",
  },
}
