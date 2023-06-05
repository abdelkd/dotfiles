keymap = vim.keymap

-- Plugins
-- Setup treesitter
require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = true,
	},
	indent = { enable = true },
})

-- Setup comment
require("Comment").setup()

-- nvim-tree
local nvim_tree_status, nvim_tree = pcall(require, "nvim-tree")
if not nvim_tree_status then
	print("Failed to require nvim-tree")
	return
end

nvim_tree.setup({
	disable_netrw = true,
	view = {
		number = true,
		relativenumber = true,
	},
	renderer = {
		icons = {
			glyphs = {
				folder = {
					arrow_closed = "",
					arrow_open = "",
				},
			},
		},
	},
	actions = {
		open_file = {
			window_picker = {
				enable = false,
			},
		},
	},
})

-- Open nvim-tree at startup
-- vim.api.nvim_create_autocmd({ "VimEnter" }, {
-- 	callback = function(data)
-- 		-- buffer is a directory
-- 		local directory = vim.fn.isdirectory(data.file) == 1
--
-- 		if not directory then
-- 			return
-- 		end
--
-- 		-- change to the directory
-- 		vim.cmd.cd(data.file)
--
-- 		require("nvim-tree.api").tree.open()
-- 	end,
-- })

-- telescope
local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
	defaults = {
		mappings = {
			i = {
				["<C-k>"] = actions.move_selection_previous,
				["<C-j>"] = actions.move_selection_next,
				["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
			},
		},
	},
})
telescope.load_extension("fzf")

-- todo comments
-- require("todo-comments").setup({})

-- nvim cmp
-- load friendly-snippets
-- require("luasnip/loaders/from_vscode").lazy_load()

local cmp = require("cmp")
-- local luasnip = require("luasnip")

cmp.setup({
	-- snippet = {
	-- 	expand = function(args)
	-- 		luasnip.lsp_expand(args.body)
	-- 	end,
	-- },
	mapping = cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
		["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-k>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
		["<C-e>"] = cmp.mapping.abort(), -- close completion window
		["<CR>"] = cmp.mapping.confirm({ select = false }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" }, -- lsp
		-- { name = "luasnip" }, -- snippets
		-- { name = "buffer" }, -- text within current buffer
		-- { name = "path" }, -- filesystem paths
	}),
})

-- LSP
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local mason_null_ls = require("mason-null-ls")

mason.setup()

mason_lspconfig.setup({
	ensure_installed = {
		-- "tsserver",
		-- "tailwindcss",
    "gopls",
		-- "html",
		-- "cssls",
    "rust_analyzer",
    "clangd",
	},
})

mason_null_ls.setup({
	ensure_installed = {
		"prettier",
		"stylua",
    "rustfmt"
	},
})

local lspconfig = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local typescript = require("typescript")

local on_attach = function(client, bufnr)
	local keymap = vim.keymap
	local opts = { noremap = true, silent = true, buffer = bufnr }

	keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts)
	keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)
	keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
	keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)
	keymap.set("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
	keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
	keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
	keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
	keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
	keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts)

	if client.name == "tsserver" then
		keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>")
	end
end
-- enable autocompletion
local capabilities = cmp_nvim_lsp.default_capabilities()

-- lspconfig["tsserver"].setup({
-- 	server = {
-- 		capabilities = capabilities,
-- 		on_attach = on_attach,
-- 	},
-- })

lspconfig["tailwindcss"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["lua_ls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = {
				-- make language server recognize "vim" global
				globals = { "vim" },
			},
			workspace = {
				-- make language server aware of runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})

require("lspconfig.configs").vtsls = require("vtsls").lspconfig -- set default server config, optional but recommended

-- If the lsp setup is taken over by other plugin, it is the same to call the counterpart setup function
require("lspconfig").vtsls.setup({ --[[ your custom server config here ]] })

lspconfig["gopls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig["rust_analyzer"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

local saga = require("lspsaga")

saga.setup({
	move_in_saga = { prev = "<C-k>", next = "<C-j>" },
	finder_action_keys = {
		open = "<CR>",
	},
	definition_action_keys = {
		edit = "<CR>",
	},
	ui = {
		border = "rounded",
	},
})

-- Null-ls
local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	source = {
		formatting.prettier,
		formatting.stylua,
		formatting.rustfmt,
	},
	-- configure format on save
	on_attach = function(current_client, bufnr)
		if current_client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						filter = function(client)
							-- only use null-ls for formatting instead of lsp server
							return client.name == "null-ls"
						end,
						bufnr = bufnr,
					})
				end,
			})
		end
	end,
})

-- golang
require('go').setup()

-- auto format on save
local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').goimport()
  end,
  group = format_sync_grp,
})

-- dap
-- keymap.set("n", "<F5>", ':lua require("dap").continue()<CR>')
-- keymap.set("n", "<F10>", '<cmd>lua require("dap").step_over()<CR>')
-- keymap.set("n", "<F11>", '<cmd>lua require("dap").step_into()<CR>')
-- keymap.set("n", "<F12>", '<cmd>lua require("dap").step_out()<CR>')
-- keymap.set("n", "<leader>b", '<cmd>lua require("dap").toggle_breakpoint()<CR>')
-- keymap.set("n", "<leader>B", '<cmd>lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>')
-- keymap.set("n", "<leader>lp", '<cmd>lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point: "))<CR>')
-- keymap.set("n", "<leader>dr", '<cmd>lua require("dap").repl.open()<CR>')
