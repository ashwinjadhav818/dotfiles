return { {
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

        function _Lazygit_toggle()
            lazygit:toggle()
        end

        local setup = {
            preset = "helix",
            icons = {mappings = false}
        }

        local mappings = {
            -- GENERAL
            { "<leader>a",   "<cmd>Alpha<cr>",                                    desc = "Alpha" },
            { "<leader>w",   "<cmd>w<CR>",                                        desc = "Save" },
            { "<leader>q",   "<cmd>q<CR>",                                        desc = "Quit" },
            { "<leader>h",   "<cmd>nohlsearch<CR>",                               desc = "No Highlight" },
            { "<leader>u",   "<cmd>undo<CR>",                                     desc = "Undo" },
            { "<leader>r",   "<cmd>redo<CR>",                                     desc = "Redo" },
            { "<leader>L",   "<cmd>Lazy<CR>",                                     desc = "Lazy" },
            { "<leader>=",   "<cmd>vertical resize +5<CR>",                       desc = "resize +5" },
            { "<leader>-",   "<cmd>vertical resize -5<CR>",                       desc = "resize -5" },
            { "<leader>v",   "<C-W>v",                                            desc = "split right" },
            { "<leader>V",   "<C-W>s",                                            desc = "split below" },
            { "<leader>q",   desc = "Close Window" },

            -- BUFFER
            { "<leader>b",   group = "Buffer" },

            -- GIT
            { "<leader>g",   group = "Git" },

            -- FIND
            { "<leader>f",   group = "Find" },

            -- LSP
            { "<leader>l",   group = "LSP" },

            -- TERMINAL
            { "<leader>t",   group = "Terminal" },
        }

        which_key.setup(setup)
        which_key.add(mappings)
    end
} }
