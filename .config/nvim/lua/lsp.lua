local mason_lspconfig = require("mason-lspconfig")
local utils = require("utils")
local lspconfig = require("lspconfig")

local lsp_configs = {
	lua_ls = {
		filetypes = { "lua" },
		settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
				},
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = { vim.env.VIMRUNTIME },
				},
			},
		},
	},
	jsonls = {
		filetypes = { "json", "jsonc" },
	},
	cssls = {
		filetypes = { "css", "scss", "less" },
	},
	yamlls = {
		filetypes = { "yaml" },
	},
	emmet_language_server = {
		filetypes = { "html", "css", "javascriptreact", "typescriptreact", "javascript", "typescript" },
	},
	ts_ls = {
		filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	},
	eslint = {
		filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	},
}

-- Setup for each language server
for server, config in pairs(lsp_configs) do
	lspconfig[server].setup(config)
end

-- Mason LSP Config
mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(lsp_configs),
	automatic_installation = true,
})

-- LSP key mappings
utils.nmap_leader("lI", "<cmd>LspInstallInfo<CR>", "Installer Info")
utils.nmap_leader("la", "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action")
utils.nmap_leader("lf", "<cmd>lua vim.lsp.buf.format{async=true}<CR>", "Format")
utils.nmap_leader("li", "<cmd>LspInfo<CR>", "Info")
utils.nmap_leader("lj", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", "Next Diagnostic")
utils.nmap_leader("lk", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", "Prev Diagnostic")
utils.nmap_leader("ll", "<cmd>lua vim.lsp.codelens.run()<CR>", "CodeLens Action")
utils.nmap_leader("lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", "Quickfix")
utils.nmap_leader("lr", "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename")
