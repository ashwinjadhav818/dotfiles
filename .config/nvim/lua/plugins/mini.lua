return {
	{
		"echasnovski/mini.nvim",
		version = false,
		config = function()
			-- Visual
			require("mini.basics").setup({
				mappings = {
					windows = true,
					move_with_alt = true,
				},
			})
			require("mini.statusline").setup()
			require("mini.tabline").setup()
			require("mini.files").setup({
				options = {
					-- Ensure paths with special characters are handled properly
					custom = function(path)
						return path:gsub("%(", "\\("):gsub("%)", "\\)")
					end,
				},
			})
			require("mini.animate").setup({ scroll = { enable = false } })

			-- Completion
			local process_items = function(items, base)
				-- Don't show 'Text' suggestions
				items = vim.tbl_filter(function(x)
					return x.kind ~= 1
				end, items)
				return MiniCompletion.default_process_items(items, base)
			end
			require("mini.completion").setup({
				lsp_completion = { source_func = "omnifunc", auto_setup = false, process_items = process_items },
			})
			local on_attach = function(args)
				vim.bo[args.buf].omnifunc = "v:lua.MiniCompletion.completefunc_lsp"
			end
			vim.api.nvim_create_autocmd("LspAttach", { callback = on_attach })
			if vim.fn.has("nvim-0.11") == 1 then
				vim.lsp.config("*", { capabilities = MiniCompletion.get_lsp_capabilities() })
			end

			local imap_expr = function(lhs, rhs)
				vim.keymap.set("i", lhs, rhs, { expr = true })
			end
			imap_expr("<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]])
			imap_expr("<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]])

			require("mini.snippets").setup()
			require("mini.comment").setup()
			require("mini.pairs").setup()

			-- Extras
			require("mini.pick").setup()
			require("mini.extra").setup()

			local miniclue = require("mini.clue")
			miniclue.setup({
				clues = {
					{ mode = "n", keys = "<Leader>f", desc = "+Find" },
					{ mode = "n", keys = "<Leader>g", desc = "+Git" },
					{ mode = "n", keys = "<Leader>r", desc = "+Refactor" },
					{ mode = "n", keys = "<Leader>b", desc = "+Buffers" },
					{ mode = "n", keys = "<Leader>l", desc = "+LSP" },
					{ mode = "n", keys = "<Leader>t", desc = "+Treminal" },
					miniclue.gen_clues.builtin_completion(),
					miniclue.gen_clues.g(),
					miniclue.gen_clues.marks(),
					miniclue.gen_clues.registers(),
					miniclue.gen_clues.windows({ submode_resize = true }),
					miniclue.gen_clues.z(),
				},
				triggers = {
					{ mode = "n", keys = "<Leader>" }, -- Leader triggers
					{ mode = "x", keys = "<Leader>" },
					{ mode = "n", keys = [[\]] }, -- mini.basics
					{ mode = "n", keys = "[" }, -- mini.bracketed
					{ mode = "n", keys = "]" },
					{ mode = "x", keys = "[" },
					{ mode = "x", keys = "]" },
					{ mode = "i", keys = "<C-x>" }, -- Built-in completion
					{ mode = "n", keys = "g" }, -- `g` key
					{ mode = "x", keys = "g" },
					{ mode = "n", keys = "'" }, -- Marks
					{ mode = "n", keys = "`" },
					{ mode = "x", keys = "'" },
					{ mode = "x", keys = "`" },
					{ mode = "n", keys = '"' }, -- Registers
					{ mode = "x", keys = '"' },
					{ mode = "i", keys = "<C-r>" },
					{ mode = "c", keys = "<C-r>" },
					{ mode = "n", keys = "<C-w>" }, -- Window commands
					{ mode = "n", keys = "z" }, -- `z` key
					{ mode = "x", keys = "z" },
				},
			})
		end,
		keys = {
			{
				"<leader>e",
				function()
					local buf_name = vim.api.nvim_buf_get_name(0)
					local dir_name = vim.fn.fnamemodify(buf_name, ":p:h")
					if vim.fn.filereadable(buf_name) == 1 then
						-- Pass the full file path to highlight the file
						require("mini.files").open(buf_name, true)
					elseif vim.fn.isdirectory(dir_name) == 1 then
						-- If the directory exists but the file doesn't, open the directory
						require("mini.files").open(dir_name, true)
					else
						-- If neither exists, fallback to the current working directory
						require("mini.files").open(vim.uv.cwd(), true)
					end
				end,
				desc = "Open mini.files (CFD or CWD)",
			},
			{
				"<leader>E",
				function()
					require("mini.files").open(vim.uv.cwd(), true)
				end,
				desc = "Open mini.files (cwd)",
			},

			-- Picker
			{
				"<leader>ff",
				function()
					require("mini.pick").builtin.files()
				end,
				desc = "Find Files",
			},
			{
				"<leader>fs",
				function()
					require("mini.pick").builtin.files()
				end,
				desc = "Smart Find Files",
			},
			{
				"<leader>fb",
				function()
					require("mini.pick").builtin.buffers()
				end,
				desc = "Buffers",
			},
			{
				"<leader>fg",
				function()
					require("mini.pick").builtin.grep_live()
				end,
				desc = "Live Grep",
			},
			{
				"<leader>fh",
				function()
					require("mini.extra").pickers.history()
				end,
				desc = "Command History",
			},
			{
				"<leader>fc",
				function()
					require("mini.pick").builtin.files(nill, { source = { cwd = vim.fn.stdpath("config") } })
				end,
				desc = "Find Config File",
			},
			{
				"<leader>fC",
				function()
					require("mini.extra").pickers.commands()
				end,
				desc = "Find Commands",
			},
			{
				"<leader>fG",
				function()
					require("mini.pick").builtin.git_files()
				end,
				desc = "Find Git Files",
			},
			{
				"<leader>fp",
				function()
					require("mini.pick").builtin.projects()
				end,
				desc = "Projects",
			},
			{
				"<leader>fr",
				function()
					require("mini.extra").pickers.oldfiles()
				end,
				desc = "Recent",
			},
		},
	},
}
