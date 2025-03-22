return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            bigfile = { enabled = true },
            indent = { enabled = true },
            input = { enabled = true },
            quickfile = { enabled = true },
            scope = { enabled = true },
            zen = { enabled = true },
            words = { enabled = true },
        },
        keys = {
            -- Picker
            { "<leader>ff", function() Snacks.picker.files() end,                                   desc = "Find Files" },
            { "<leader>fs", function() Snacks.picker.smart() end,                                   desc = "Smart Find Files" },
            { "<leader>fb", function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
            { "<leader>fg", function() Snacks.picker.grep() end,                                    desc = "Grep" },
            { "<leader>fh", function() Snacks.picker.command_history() end,                         desc = "Command History" },
            { "<leader>fn", function() Snacks.picker.notifications() end,                           desc = "Notification History" },
            { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
            { "<leader>fG", function() Snacks.picker.git_files() end,                               desc = "Find Git Files" },
            { "<leader>fp", function() Snacks.picker.projects() end,                                desc = "Projects" },
            { "<leader>fr", function() Snacks.picker.recent() end,                                  desc = "Recent" },

            -- Others
            { "<leader>z",  function() Snacks.zen() end,                                            desc = "Zen Mode" },
        }
    }
}
