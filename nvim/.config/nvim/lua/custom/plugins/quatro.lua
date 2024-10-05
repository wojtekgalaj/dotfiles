return {

  { -- requires plugins in lua/plugins/treesitter.lua and lua/plugins/lsp.lua
    -- for complete functionality (language features)
    "quarto-dev/quarto-nvim",
    ft = { "quarto" },
    dev = false,
    opts = {
      lspFeatures = {
        languages = { "r", "python", "bash", "lua", "html", "javascript", "typescript" },
      },
      codeRunner = {
        enabled = true,
        default_method = "slime",
      },
    },
    dependencies = {
      -- for language features in code cells
      -- configured in lua/plugins/lsp.lua and
      -- added as a nvim-cmp source in lua/plugins/completion.lua
      "jmbuhr/otter.nvim",
    },
  },

  { -- directly open ipynb files as quarto docuements
    -- and convert back behind the scenes
    "GCBallesteros/jupytext.nvim",
    opts = {
      custom_language_formatting = {
        python = {
          extension = "qmd",
          style = "quarto",
          force_ft = "quarto",
        },
      },
    },
  },

  { -- send code from python/r/qmd documets to a terminal or REPL
    -- like ipython, R, bash
    "jpalardy/vim-slime",
    dev = false,
    init = function()
      vim.b["quarto_is_python_chunk"] = false
      Quarto_is_in_python_chunk = function()
        require("otter.tools.functions").is_otter_language_context "python"
      end

      vim.cmd [[
      let g:slime_dispatch_ipython_pause = 100
      function SlimeOverride_EscapeText_quarto(text)
      call v:lua.Quarto_is_in_python_chunk()
      if exists('g:slime_python_ipython') && len(split(a:text,"\n")) > 1 && b:quarto_is_python_chunk && !(exists('b:quarto_is_r_mode') && b:quarto_is_r_mode)
      return ["%cpaste -q\n", g:slime_dispatch_ipython_pause, a:text, "--", "\n"]
      else
      if exists('b:quarto_is_r_mode') && b:quarto_is_r_mode && b:quarto_is_python_chunk
      return [a:text, "\n"]
      else
      return [a:text]
      end
      end
      endfunction
      ]]

      vim.g.slime_target = "neovim"
      vim.g.slime_no_mappings = true
      vim.g.slime_python_ipython = 1
    end,
    config = function()
      vim.g.slime_input_pid = false
      vim.g.slime_suggest_default = true
      vim.g.slime_menu_config = false
      vim.g.slime_neovim_ignore_unlisted = true

      local function mark_terminal()
        local job_id = vim.b.terminal_job_id
        vim.print("job_id: " .. job_id)
      end

      local function set_terminal()
        vim.fn.call("slime#config", {})
      end
      vim.keymap.set("n", "<leader>cm", mark_terminal, { desc = "[m]ark terminal" })
      vim.keymap.set("n", "<leader>cs", set_terminal, { desc = "[s]et terminal" })
    end,
  },

  { -- paste an image from the clipboard or drag-and-drop
    "HakonHarnes/img-clip.nvim",
    lazy = true,
    event = "BufEnter",
    ft = { "markdown", "quarto", "latex" },
    opts = {
      default = {
        dir_path = "img",
      },
      filetypes = {
        markdown = {
          url_encode_path = true,
          template = "![$CURSOR]($FILE_PATH)",
          drag_and_drop = {
            download_images = false,
          },
        },
        quarto = {
          url_encode_path = true,
          template = "![$CURSOR]($FILE_PATH)",
          drag_and_drop = {
            download_images = false,
          },
        },
      },
    },
  },
}
