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

opt.wrap = false
