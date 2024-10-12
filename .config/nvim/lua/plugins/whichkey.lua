return {{
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    config = function()
        local status_ok, which_key = pcall(require, "which-key")
        if not status_ok then
            return
        end

        local Terminal = require('toggleterm.terminal').Terminal
        local lazygit = Terminal:new({
            cmd = "lazygit",
            hidden = true,
            direction = "float"
        })

        function _lazygit_toggle()
            lazygit:toggle()
        end

        local setup = {
            preset = "modern",

        }

        local mappings = {
            {
                "<leader>a",
                "<cmd>Alpha<cr>",
                desc = "Alpha"
            },
            {
                "<leader>e",
                "<cmd>NvimTreeToggle<cr>",
                desc = "Explorer"
            },
            {
                "<leader>w",
                "<cmd>w<CR>",
                desc = "Save"
            },
            {
                "<leader>q",
                "<cmd>q<CR>",
                desc = "Quit"
            },
            {
                "<leader>d",
                "<cmd>Bdelete!<CR>",
                desc = "Close Buffer"
            },
            {
                "<leader>h",
                "<cmd>nohlsearch<CR>",
                desc = "No Highlight"
            },
            {
                "<leader>u",
                "<cmd>undo<CR>",
                desc = "Undo"
            },
            {
                "<leader>r",
                "<cmd>redo<CR>",
                desc = "Redo"
            },
            {
                "<leader>L",
                "<cmd>Lazy<CR>",
                desc = "Lazy"
            },

            -- CODE
            {
                "<leader>c",
                group = "Code"
            },
            {
                "<leader>co",
                "<cmd>lua require'jdtls'.organize_imports()<cr>",
                desc = "Organize Imports"
            },
            {
                "<leader>cv",
                "<cmd>lua require('jdtls').extract_variable()<cr>",
                desc = "Extract Variable"
            },
            {
                "<leader>cc",
                "<cmd>lua require('jdtls').extract_constant()<cr>",
                desc = "Extract Constant"
            },
            {
                "<leader>cm",
                "<cmd>lua require('jdtls').extract_method(true)<cr>",
                desc = "Extract Method"
            },
            {
                "<leader>ct",
                "<cmd>lua require('jdtls').test_class()<cr>",
                desc = "Test Class"
            },
            {
                "<leader>cn",
                "<cmd>lua require('jdtls').test_nearest_method()<cr>",
                desc = "Test Nearest Method"
            },

            -- GIT
            {
                "<leader>g",
                group = "Git"
            },
            {
                "<leader>gg",
                "<cmd>lua _lazygit_toggle()<CR>",
                desc = "Lazygit"
            },
            {
                "<leader>gj",
                "<cmd>lua require 'gitsigns'.next_hunk()<cr>",
                desc = "Next Hunk"
            },
            {
                "<leader>gk",
                "<cmd>lua require 'gitsigns'.prev_hunk()<cr>",
                desc = "Prev Hunk"
            },
            {
                "<leader>gl",
                "<cmd>lua require 'gitsigns'.blame_line()<cr>",
                desc = "Blame"
            },
            {
                "<leader>gp",
                "<cmd>lua require 'gitsigns'.preview_hunk()<cr>",
                desc = "Preview Hunk"
            },
            {
                "<leader>gr",
                "<cmd>lua require 'gitsigns'.reset_hunk()<cr>",
                desc = "Reset Hunk"
            },
            {
                "<leader>gR",
                "<cmd>lua require 'gitsigns'.reset_buffer()<cr>",
                desc = "Reset Buffer"
            },
            {
                "<leader>gs",
                "<cmd>lua require 'gitsigns'.stage_hunk()<cr>",
                desc = "Stage Hunk"
            },
            {
                "<leader>gu",
                "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
                desc = "Undo Stage Hunk"
            },
            {
                "<leader>go",
                "<cmd>Telescope git_status<cr>",
                desc = "Open changed file"
            },
            {
                "<leader>gb",
                "<cmd>Telescope git_branches<cr>",
                desc = "Checkout branch"
            },
            {
                "<leader>gc",
                "<cmd>Telescope git_commits<cr>",
                desc = "Checkout commit"
            },
            {
                "<leader>gd",
                "<cmd>Gitsigns diffthis HEAD<cr>",
                desc = "Diff"
            },

            -- FIND
            {
                "<leader>f",
                group = "Find"
            },
            {
                "<leader>fb",
                "<cmd>Telescope buffers<cr>",
                desc = "Buffers"
            },
            {
                "<leader>fc",
                "<cmd>Telescope colorscheme<cr>",
                desc = "Colorscheme"
            },
            {
                "<leader>ff",
                "<cmd> Telescope find_files<cr>",
                desc = "Files"
            },
            {
                "<leader>fh",
                "<cmd>Telescope help_tags<cr>",
                desc = "Find Help"
            },
            {
                "<leader>fM",
                "<cmd>Telescope man_pages<cr>",
                desc = "Man Pages"
            },
            {
                "<leader>fp",
                "<cmd>Telescope projects<cr>",
                desc = "Projects"
            },
            {
                "<leader>fr",
                "<cmd>Telescope oldfiles<cr>",
                desc = "Open Recent File"
            },
            {
                "<leader>fR",
                "<cmd>Telescope registers<cr>",
                desc = "Registers"
            },
            {
                "<leader>fk",
                "<cmd>Telescope keymaps<cr>",
                desc = "Keymaps"
            },
            {
                "<leader>fC",
                "<cmd>Telescope commands<cr>",
                desc = "Commands"
            },

            -- LSP
            {
                "<leader>l",
                group = "LSP"
            },
            {
                "<leader>la",
                "<cmd>lua vim.lsp.buf.code_action()<cr>",
                desc = "Code Action"
            },
            {
                "<leader>ld",
                "<cmd>Telescope diagnostics bufnr=0<cr>",
                desc = "Document Diagnostics"
            },
            {
                "<leader>lw",
                "<cmd>Telescope diagnostics<cr>",
                desc = "Workspace Diagnostics"
            },
            {
                "<leader>lf",
                "<cmd>lua vim.lsp.buf.format{async=true}<cr>",
                desc = "Format"
            },
            {
                "<leader>li",
                "<cmd>LspInfo<cr>",
                desc = "Info"
            },
            {
                "<leader>lI",
                "<cmd>LspInstallInfo<cr>",
                desc = "Installer Info"
            },
            {
                "<leader>lj",
                "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
                desc = "Next Diagnostic"
            },
            {
                "<leader>lk",
                "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
                desc = "Prev Diagnostic"
            },
            {
                "<leader>ll",
                "<cmd>lua vim.lsp.codelens.run()<cr>",
                desc = "CodeLens Action"
            },
            {
                "<leader>lq",
                "<cmd>lua vim.diagnostic.setloclist()<cr>",
                desc = "Quickfix"
            },
            {
                "<leader>lr",
                "<cmd>lua vim.lsp.buf.rename()<cr>",
                desc = "Rename"
            },
            {
                "<leader>ls",
                "<cmd>Telescope lsp_document_symbols<cr>",
                desc = "Document Symbols"
            },
            {
                "<leader>lS",
                "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
                desc = "Workspace Symbols"
            },

            -- TERMINAL
            {
                "<leader>t",
                group = "Terminal"
            },
            name = "Terminal",
            {
                "<leader>tn",
                "<cmd>lua _NODE_TOGGLE()<cr>",
                desc = "Node"
            },
            {
                "<leader>tu",
                "<cmd>lua _NCDU_TOGGLE()<cr>",
                desc = "NCDU"
            },
            {
                "<leader>tt",
                "<cmd>lua _HTOP_TOGGLE()<cr>",
                desc = "Htop"
            },
            {
                "<leader>tp",
                "<cmd>lua _PYTHON_TOGGLE()<cr>",
                desc = "Python"
            },
            {
                "<leader>tf",
                "<cmd>ToggleTerm direction=float<cr>",
                desc = "Float"
            },
            {
                "<leader>th",
                "<cmd>ToggleTerm size=10 direction=horizontal<cr>",
                desc = "Horizontal"
            },
            {
                "<leader>tv",
                "<cmd>ToggleTerm size=80 direction=vertical<cr>",
                desc = "Vertical"
            }
        }

        which_key.setup(setup)
        which_key.add(mappings)
    end
}}
