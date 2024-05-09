-- This file contains all the remaps
-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.netrw_banner = 0
vim.g.netrw_cursor = 0
vim.g.netrw_dirhistmax = 0

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- Clear highlights
vim.keymap.set("n", "<esc>", "<cmd>:noh<cr>", { noremap = true })

-- For when I don't have my keyboard. ESC is so dang far away.
vim.keymap.set("i", "jk", "<Esc>")

-- Use Ctrl + hjkl to navigate splits
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { noremap = true })

local which_key = require("which-key")
local builtin = require("telescope.builtin")
local notify = require("telescope").extensions.notify

which_key.register({
	g = {
		name = "[G]o to...",
		d = {
			vim.lsp.buf.definition,
			"[D]efinition",
		},
		k = {
			vim.lsp.buf.declaration,
			"de[K]laration",
		},
		r = {
			builtin.lsp_references,
			"[R]eferences",
		},
		i = {
			vim.lsp.buf.implementation,
			"[I]mplementation",
		},
		t = {
			vim.lsp.buf.type_definition,
			"[T]ype definition",
		},
		s = {
			name = "[S]ymbols...",
			d = {
				builtin.lsp_document_symbols,
				"[D]ocument symbols",
			},
			w = {
				builtin.lsp_dynamic_workspace_symbols,
				"[W]orkspace symbols",
			},
		},
	},
	["<leader>"] = {
		["<space>"] = {
			builtin.find_files,
			"[SPACE] List files in project",
		},
		["/"] = {
			builtin.current_buffer_fuzzy_find,
			"[/] Fuzzily search in current buffer]",
		},
		b = {
			name = "[B]uffer",
			d = {
				name = "[D]elete",
				"<cmd>bdel<cr>",
			},
		},
		j = {
			"<cmd>wa<cr>",
			"[J]ust save all",
		},
		f = {
			"<cmd>cclose<cr>",
			"Close Quick[F]ix",
		},
		q = {
			"<cmd>q<cr>",
			"[Q]uit",
		},
		e = {
			vim.diagnostic.open_float,
			"[E]rrors",
		},

		w = {
			name = "[W]indow",
			["s"] = {
				"<cmd>vertical resize -50<cr>",
				"make window [S]maller",
			},
			["l"] = {
				"<cmd>vertical resize +50<cr>",
				"make window [L]arger",
			},
		},
		g = {
			name = "[G]it",
			v = {
				"<cmd>Neogit<cr>",
				"[V]ersion control",
			},
			b = {
				"<cmd>Git blame<cr>",
				"[B]lame",
			},
		},
		l = {
			name = "[L]SP",
			c = {
				name = "[C]ode",
				a = {
					vim.lsp.buf.code_action,
					"[A]ctions",
				},
			},
			r = {
				vim.lsp.buf.rename,
				"[R]ename",
			},
			h = {
				name = "[H]elp",
				d = {
					vim.lsp.buf.signature_help,
					"Signature [D]ocumentation",
				},
			},
			w = {
				name = "[W]orkspace",
				a = {
					vim.lsp.buf.add_workspace_folder,
					"[A]dd folder",
				},
				r = {
					vim.lsp.buf.remove_workspace_folder,
					"[R]emove folder",
				},
				l = {
					vim.lsp.buf.list_workspace_folders,
					"[L]ist folders",
				},
			},
		},
		s = {
			name = "[S]earch",
			a = {
				builtin.git_commits,
				"[A]ll commits",
			},
			c = {
				builtin.git_bcommits,
				"buffer [C]ommits",
			},
			d = {
				builtin.diagnostics,
				"[D]iagnostics",
			},
			g = {
				builtin.live_grep,
				"[G]rep in project",
			},
			h = {
				builtin.help_tags,
				"[H]elp tags",
			},
			j = {
				builtin.jumplist,
				"[J]umplist",
			},
			n = {
				notify.notify,
				"[N]otifications",
			},
			r = {
				builtin.resume,
				"[R]esume last search",
			},
			s = {
				builtin.buffers,
				"buffer[S]",
			},
			u = {
				builtin.grep_string,
				"grep whats [U]nder cursor",
			},
			q = {
				builtin.quickfixhistory,
				"[Q]uickfix history",
			},
		},
	},
}, { mode = "n", silent = true, noremap = true })
