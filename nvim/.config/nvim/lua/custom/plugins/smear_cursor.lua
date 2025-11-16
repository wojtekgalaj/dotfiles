return {
  {
    "sphamba/smear-cursor.nvim",
    enabled = true,
    opts = {
      -- Smear cursor when switching buffers or windows.
      smear_between_buffers = false,

      -- Smear cursor when moving within line or to neighbor lines.
      smear_between_neighbor_lines = true,

      -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
      -- Smears will blend better on all backgrounds.
      legacy_computing_symbols_support = true,
    },
  },
}
