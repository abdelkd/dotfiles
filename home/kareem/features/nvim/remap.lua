local keymap = vim.keymap.set
local default_opts = { noremap = true, silent = true }

keymap("n", "<leader>pv", vim.cmd.Ex, default_opts)

-- buffers
--keymap("n", "<C-l>", vim.cmd.bnext, default_opts)
--keymap("n", "<C-h>", vim.cmd.bprevious, default_opts)

-- close other splits
keymap("n", "<leader>o", vim.cmd.only)

-- Append line below to the current line
keymap("n", "J", "mzJ`z")

-- Jump pages with keeping cursor at same place
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

keymap("n", "n", "nzzzv", { desc = "Next term" })
keymap("n", "N", "Nzzzv", { desc = "Previous term" })

keymap("x", "<leader>p", "\"_dP")

-- yank into system clipboard
keymap("n", "<leader>y", "\"+y")
keymap("v", "<leader>y", "\"+y")
keymap("n", "<leader>Y", "\"+Y")

-- delete into void
keymap("n", "<leader>d", "\"_d")
keymap("n", "x", "\"_x")

-- quick fix navigation
keymap("n", "<C-k>", "<cmd>cnext<CR>zz")
keymap("n", "<C-j>", "<cmd>cprev<CR>zz")
keymap("n", "<leader>k", "<cmd>lnext<CR>zz")
keymap("n", "<leader>j", "<cmd>lprev<CR>zz")


--keymap("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
--keymap("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
--keymap("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
--keymap("n", "<leader>f", vim.lsp.buf.format, { desc = "Format code" })
--keymap("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
--keymap("n", "<leader>c", vim.lsp.buf.code_action, { desc = "Code action" })

-- Diagnostic
--keymap("n", "<leader>e", vim.diagnostic.open_float, { desc = "Floatin diagnostic" })
--keymap("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
--keymap("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
--keymap("n", "gl", vim.diagnostic.setloclist, { desc = "Diagnostics on lolist" })
--keymap("n", "gq", vim.diagnostic.setqflist, { desc = "Diagnostics on quickfix" })


-- Undotree
keymap("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Undotree toggle" })

keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")

-- Use <leader>+ and <leader>- to increment/decrement numbers
keymap("n", "<leader>+", "<C-a>")
keymap("s", "<leader>-", "<C-x>")

-- splits
keymap("n", "<leader>sv", "<C-w>v")
keymap("n", "<leader>sh", "<C-w>s")
keymap("n", "<leader>se", "<C-w>=")
keymap("n", "<leader>sx", ":close<CR>")

-- tabs
keymap("n", "<leader>to", ":tabnew<CR>")
keymap("n", "<leader>tx", ":tabclose<CR>")
keymap("n", "<leader>tn", ":tabn<CR>")
keymap("n", "<leader>tp", ":tabp<CR>")

-- vim-maximizer
keymap("n", "<leader>sm", ":MaximizerToggle<CR>")

-- NeoTree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>")

-- Telescope
keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
keymap("n", "<leader>fs", "<cmd>Telescope live_grep<CR>")
keymap("n", "<leader>fc", "<cmd>Telescope grep_string<CR>")
keymap("n", "<leader>fb", "<cmd>Telescope buffers<CR>")
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<CR>")
