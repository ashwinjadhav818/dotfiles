return {
    {
        "nvim-telescope/telescope.nvim",
        config = function()
            local telescope = require("telescope")
            local telescopeConfig = require("telescope.config")

            -- Clone the default Telescope configuration
            local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

            -- Enables hidden folder arg
            table.insert(vimgrep_arguments, "--hidden")
            -- Ignores .git folder
            table.insert(vimgrep_arguments, "--glob")
            table.insert(vimgrep_arguments, "!**/.git/*")

            telescope.setup({
                defaults = {
                    -- `hidden = true` is not supported in text grep commands.
                    vimgrep_arguments = vimgrep_arguments,
                },
                pickers = {
                    find_files = {
                        -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
                        find_command = { "rg", "--files", "--hidden", "--smart-case", "--glob", "!**/.git/*", "--path-separator", "/" },
                    },
                },
            })
        end,
        keys = {
            -- FIND
            { "<leader>fb", "<cmd>Telescope buffers<cr>",     desc = "Buffers" },
            { "<leader>fc", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>",   desc = "Live Grep" },
            { "<leader>ff", "<cmd>Telescope find_files<cr>",  desc = "Files" },
            { "<leader>fh", "<cmd>Telescope help_tags<cr>",   desc = "Find Help" },
            { "<leader>fM", "<cmd>Telescope man_pages<cr>",   desc = "Man Pages" },
            { "<leader>fp", "<cmd>Telescope projects<cr>",    desc = "Projects" },
            { "<leader>fr", "<cmd>Telescope oldfiles<cr>",    desc = "Open Recent File" },
            { "<leader>fR", "<cmd>Telescope registers<cr>",   desc = "Registers" },
            { "<leader>fk", "<cmd>Telescope keymaps<cr>",     desc = "Keymaps" },
            { "<leader>fC", "<cmd>Telescope commands<cr>",    desc = "Commands" },

            -- GIT
            { "<leader>go",  "<cmd>Telescope git_status<cr>",                     desc = "Open changed file" },
            { "<leader>gb",  "<cmd>Telescope git_branches<cr>",                   desc = "Checkout branch" },
            { "<leader>gc",  "<cmd>Telescope git_commits<cr>",                    desc = "Checkout commit" },
        },
        dependencies = { "nvim-lua/plenary.nvim" }
    },
}
