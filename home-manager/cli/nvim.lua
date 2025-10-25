---@diagnostic disable: undefined-global
vim.g.mapleader = " "
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.have_nerd_font = true
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.inccommand = "split"
vim.opt.winborder = "rounded"
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.showtabline = 2
vim.opt.showmode = false
vim.opt.laststatus = 3

-- Tab management
local tab_keybinds = {
	["<A-1>"] = ":tabnext 1<CR>",
	["<A-2>"] = ":tabnext 2<CR>",
	["<A-3>"] = ":tabnext 3<CR>",
	["<A-4>"] = ":tabnext 4<CR>",
	["<A-w>"] = ":tabclose<CR>",
	["<A-a>"] = ":tabnew<CR>",
	["<A-n>"] = ":tabnext<CR>",
}
-- Manage tabs in normal and terminal mode
for key, cmd in pairs(tab_keybinds) do
	vim.keymap.set("n", key, cmd, { noremap = true, silent = true })
	vim.keymap.set("t", key, "<C-\\><C-n>" .. cmd, { noremap = true, silent = true })
end

-- Window management
vim.keymap.set("n", "<C-h>", "<c-w><c-h>")
vim.keymap.set("n", "<C-l>", "<c-w><c-l>")
vim.keymap.set("n", "<C-j>", "<c-w><c-j>")
vim.keymap.set("n", "<C-k>", "<c-w><c-k>")
vim.keymap.set("n", "<C-w>S", ":vert sball<cr>", { desc = "Split all buffers" })

-- Quality of Life
vim.cmd([[
  ca Q q
  ca W w
  ca Wq wq
]])
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv")
vim.keymap.set({ "n", "v" }, "<leader>d", [[d]])
vim.keymap.set({ "n", "v" }, "d", [["_d]])
vim.keymap.set("x", "p", [["_dP]])
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- Highlight when copying text
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
-- Folding
-- Auto folding configuration for markdown / other languages
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		local parsers = require("nvim-treesitter.parsers")
		if parsers.has_parser() then
			vim.wo.foldmethod = "expr"
			vim.wo.foldexpr   = "nvim_treesitter#foldexpr()"
		else
			vim.wo.foldmethod = "syntax"
		end
		vim.wo.foldlevel = 99
		vim.wo.foldenable = true
	end,
})

-- Gitsgins
require('gitsigns').setup {
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
}
-- Theme
require("tokyonight").setup()
vim.cmd.colorscheme("tokyonight-night")
vim.cmd([[ highlight Normal ctermbg=none guibg=none ]])
-- Lualine
require('lualine').setup()
-- File explorer
require("mini.files").setup({
	mappings = {
		close = '<esc>',
		synchronize = 's',
		go_in_plus = "<CR>",
	},
	windows = {
		preview = true,
		width_preview = 50,
	},
})
vim.keymap.set("n", "<leader>e", function() require("mini.files").open(vim.api.nvim_buf_get_name(0), true) end)
vim.keymap.set("n", "<leader>E", ":Open .<CR>")
-- Snacks
require('snacks').setup {
	bigfile = { enabled = true },
	quickfile = { enabled = true },
	picker = { enabled = true },
	notifier = { enabled = true },
	scope = { enabled = true },
	words = { enabled = true },
	indent = { enabled = true },
	scroll = { enabled = true },
	terminal = {
		win = {
			keys = {
				term_normal = {
					"<esc>",
					function() vim.cmd("stopinsert") end,
					mode = "t",
					desc = "Single escape to normal mode",
				},
			},
			wo = { winbar = "" },
		},
	},
	image = { enabled = true },
}
-- Picker
vim.keymap.set("n", "<leader><space>", function() Snacks.picker.zoxide({ layout = { preset = "vscode" } }) end)
vim.keymap.set("n", "<leader>/", function() Snacks.picker.grep() end)
vim.keymap.set("n", "<leader>b", function() Snacks.picker.buffers() end)
-- All pickers
vim.keymap.set("n", "<leader>a", function() Snacks.picker.pickers() end)
-- Undo history
vim.keymap.set("n", "<leader>u", function() Snacks.picker.undo() end)
-- Git
vim.keymap.set("n", "<leader>gs", function() Snacks.picker.git_status() end)
vim.keymap.set("n", "<leader>gb", function() Snacks.git.blame_line() end)
-- Open current file in Github
vim.keymap.set("n", "<leader>gh", function() Snacks.gitbrowse() end)
-- Terminal
vim.keymap.set({ "n", "t" }, "<C-Space>", function()
	local term = Snacks.terminal
	term.toggle()
	vim.api.nvim_buf_set_name(term.get().buf, " Terminal")
end)
-- Diagnostics toggle
Snacks.toggle.diagnostics():map("<leader>h")
-- Zen mode toggle
Snacks.toggle.zen():map("<leader>z")
-- LSP setup
vim.diagnostic.config({
	virtual_text = true,
	underline = true,
	signs = true,
})
-- Treesitter setup
require("nvim-treesitter.install").prefer_git = true
require("nvim-treesitter.install").compilers = { "zig", "gcc" }
require("nvim-treesitter.configs").setup {
	parser_install_dir = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/",
	auto_install = false,
	highlight = {
		enable = true,
	},
	indent = { enable = true },
}
-- LSP completion setup
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig.lua_ls.setup { capabilities = capabilities }
lspconfig.gopls.setup { capabilities = capabilities }
lspconfig.pyright.setup { capabilities = capabilities }
lspconfig.nil_ls.setup { capabilities = capabilities }
lspconfig.ts_ls.setup { capabilities = capabilities }
lspconfig.eslint.setup { capabilities = capabilities }

local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		['<C-Space>'] = cmp.mapping.complete(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
		['<Tab>'] = cmp.mapping.select_next_item(),
		['<S-Tab>'] = cmp.mapping.select_prev_item(),
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
	}, {
		{ name = 'buffer' },
	})
}
-- LSP keymaps
vim.keymap.set("n", "<leader>l", vim.lsp.buf.format)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
