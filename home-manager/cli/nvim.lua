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
vim.keymap.set("n", "<C-w>T", ":tab sball<cr>", { desc = "Tab all splits" })

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
-- vim.keymap.set("x", "p", [["_dP]])
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- Highlight when copying text
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
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
-- Picker
require("mini.pick").setup()
vim.keymap.set("n", "<leader>f", ":Pick files<CR>")
vim.keymap.set("n", "<leader>b", ":Pick buffers<CR>")
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
-- Undotree
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
-- Toggle Terminal
local term_buf = nil
local term_win = nil
vim.keymap.set({ "n", "t" }, "<C-\\>", function()
	if term_win and vim.api.nvim_win_is_valid(term_win) then
		if vim.api.nvim_get_current_win() == term_win then
			vim.cmd.hide()
		else
			vim.api.nvim_set_current_win(term_win)
			vim.cmd.startinsert()
		end
		return
	end
	if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
		vim.cmd.split()
		vim.cmd.wincmd("J")
		vim.api.nvim_win_set_height(0, 10)
		vim.api.nvim_win_set_buf(0, term_buf)
		term_win = vim.api.nvim_get_current_win()
		vim.cmd.startinsert()
		return
	end
	vim.cmd.split()
	vim.cmd.term()
	vim.cmd.wincmd("J")
	vim.api.nvim_buf_set_name(0, "Toggle Terminal")
	vim.api.nvim_win_set_height(0, 10)
	term_win = vim.api.nvim_get_current_win()
	term_buf = vim.api.nvim_get_current_buf()
	vim.fn.chansend(vim.b.terminal_job_id, "clear\n")
	vim.cmd.startinsert()
end)
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.cmd("highlight! link NormalNC Normal")

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
		{ name = 'supermaven' },
	}, {
		{ name = 'buffer' },
	})
}
-- LSP keymaps
vim.keymap.set("n", "<leader>l", vim.lsp.buf.format)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
-- Disable LSP errors on keybind
local isLspDiagnosticsVisible = true
vim.keymap.set("n", "<leader>h", function()
	isLspDiagnosticsVisible = not isLspDiagnosticsVisible
	vim.diagnostic.config({
		virtual_text = isLspDiagnosticsVisible,
		underline = isLspDiagnosticsVisible,
		signs = true,
	})
end)
