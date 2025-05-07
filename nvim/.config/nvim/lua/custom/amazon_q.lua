-- Amazon Q integration for Neovim
local M = {}

local function amazon_q_query(text)
  -- Create a new split window for the response
  vim.cmd "vnew"
  local buf = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_name(buf, "Amazon Q Response")

  -- Set buffer options
  vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
  vim.api.nvim_buf_set_option(buf, "swapfile", false)
  vim.api.nvim_buf_set_option(buf, "filetype", "markdown")

  -- Show loading message
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "Loading response from Amazon Q..." })

  -- Execute Amazon Q CLI command
  local job = require "plenary.job"
  job
    :new({
      command = "q",
      args = { "chat", "--no-interactive", text },
      on_stdout = function(err, data)
        if err then
          print(err)
          return
        end
        if data then
          -- Append output line by line
          vim.schedule(function()
            local line_count = vim.api.nvim_buf_line_count(buf)
            if
              line_count == 1
              and vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] == "Loading response from Amazon Q..."
            then
              -- Replace loading message with first line of output
              vim.api.nvim_buf_set_lines(buf, 0, 1, false, { data })
            else
              -- Append subsequent lines
              vim.api.nvim_buf_set_lines(buf, line_count, line_count, false, { data })
            end
          end)
        end
      end,
      on_stderr = function(_, data)
        if data and data ~= "" then
          vim.schedule(function()
            local line_count = vim.api.nvim_buf_line_count(buf)
            vim.api.nvim_buf_set_lines(buf, line_count, line_count, false, { "Error: " .. data })
          end)
        end
      end,
      on_exit = function(j, return_val)
        if return_val ~= 0 then
          vim.schedule(function()
            local line_count = vim.api.nvim_buf_line_count(buf)
            vim.api.nvim_buf_set_lines(
              buf,
              line_count,
              line_count,
              false,
              { "Command exited with code " .. return_val }
            )
          end)
        end
      end,
    })
    :start()
end

local function get_visual_selection()
  -- Get the current mode
  local mode = vim.fn.mode()

  -- Ensure we are in visual mode
  if mode ~= "v" and mode ~= "V" and mode ~= "\22" then
    return nil, "Not in visual mode"
  end

  -- Get the start and end positions of the selection
  local start_pos = vim.fn.getpos "'<"
  local end_pos = vim.fn.getpos "'>"

  -- Extract the lines from the buffer
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, start_pos[2] - 1, end_pos[2], false)
  print "lines below"
  print(lines)
  print "---"

  -- Adjust for column positions
  if #lines == 1 then
    -- Single-line selection
    lines[1] = string.sub(lines[1], start_pos[3], end_pos[3])
  else
    -- Multi-line selection
    lines[1] = string.sub(lines[1], start_pos[3])
    lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])
  end

  return lines
end

-- Function to ask Amazon Q about selected text
function M.ask_amazon_q()
  local selected_text = get_visual_selection()
  if selected_text and selected_text ~= "" then
    amazon_q_query(selected_text)
  else
    -- If no selection, prompt for input
    vim.ui.input({ prompt = "Ask Amazon Q: " }, function(input)
      if input and input ~= "" then
        amazon_q_query(input)
      end
    end)
  end
end

-- Function to ask Amazon Q with prompt
function M.prompt_amazon_q()
  vim.ui.input({ prompt = "Ask Amazon Q: " }, function(input)
    if input and input ~= "" then
      amazon_q_query(input)
    end
  end)
end

-- Setup function to initialize keymaps and commands
function M.setup()
  -- Set up keymaps
  vim.keymap.set("v", "<leader>aq", function()
    M.ask_amazon_q()
  end, { noremap = true, silent = true, desc = "Ask Amazon Q about selection" })

  vim.keymap.set("n", "<leader>aq", function()
    M.prompt_amazon_q()
  end, { noremap = true, silent = true, desc = "Ask Amazon Q" })

  -- Register commands
  vim.api.nvim_create_user_command("AmazonQ", function(opts)
    amazon_q_query(opts.args)
  end, { nargs = "+" })
end

return M
