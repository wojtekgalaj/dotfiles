local opt = vim.o

----- Interesting Options -----

-- You have to turn this one on :)
opt.inccommand = "split"

-- Best search settings :)
opt.smartcase = true
opt.ignorecase = true

opt.clipboard = "unnamedplus"

-- Case insensitive searching UNLESS /C or capital in search
opt.ignorecase = true
opt.smartcase = true

opt.signcolumn = "yes"

opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.conceallevel = 2

opt.scrolloff = 6

opt.wrap = true

opt.guicursor = "n-v-c:block-Cursor/lCursor,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor"

--- This is an attempt at a nicer normal mode cursor. One that would not get in the way of the text under it.
--- Here I'm trying a thin underscore like cursor. It is difficult to spot though so I need a better option.
-- opt.guicursor = "n-v-c:hor50-Cursor,i-ci:ver25-Cursor/lCursor,r-cr:block-Cursor/lCursor,a:blinkon100-Cursor/lCursor"
