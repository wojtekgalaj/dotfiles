return {
  {
    "chrisgrieser/nvim-recorder",
    dependencies = "rcarriga/nvim-notify", -- optional
    opts = {
      slots = { "a", "b", "c", "d" },
      mapping = {
        startStopRecording = "q",
        playMacro = "Q",
        switchSlot = "<M-q>",
        editMacro = "cq",
        deleteAllMacros = "dq",
        yankMacro = "yq",
        -- ⚠️ this should be a string you don't use in insert mode during a macro
        addBreakPoint = "##",
      },
    },
  },
}
