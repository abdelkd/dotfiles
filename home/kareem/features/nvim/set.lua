local cmd = vim.cmd
local opt = vim.opt
local g = vim.g

-- set colorscheme
-- cmd.colorscheme("tokyonight-storm")
cmd.colorscheme("catppuccin-mocha")

-- Use system clipboard
opt.clipboard = "unnamedplus"

-- Tabs
opt.tabstop = 2
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.softtabstop = 2

-- Line numbers
opt.number = true
opt.relativenumber = true

opt.guicursor = ""

opt.wrap = false

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

opt.hlsearch = false
opt.incsearch = true

opt.termguicolors = true

opt.scrolloff = 8
opt.signcolumn = "yes"
opt.isfname:append("@-@")

opt.colorcolumn = "80"

opt.completeopt = "menu,menuone,noselect"

g.mapleader = " "

-- NvimTree
g.netrw = 1
g.netrwPlugin = 1

vim.cmd([[ highlight NvimTreeIndentMarker guifg=#89dceb ]])
