--- This is a plugin for simpler search and replace across the whole project.
--- It's not currently as well documented as I'd like, nor is it properly set up.
--- I still have to decide if this is better than leanring grep and sed properly.
--- All of this can also be done using quickfix and substitute, I just don't know how.
return { {
  "nvim-pack/nvim-spectre",
  config = function()
    require("spectre").setup()
  end,
} }
