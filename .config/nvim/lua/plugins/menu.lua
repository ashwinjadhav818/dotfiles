return {
    { "nvzone/volt", lazy = true },
    {
        "nvzone/menu",
        lazy = false,
        config = function()
            local menu = require("menu")

            -- Keyboard users
            vim.keymap.set("n", "<C-t>", function()
                menu.open("default")
            end, {})

            -- mouse users + nvimtree users!
            vim.keymap.set("n", "<RightMouse>", function()
                vim.cmd.exec '"normal! \\<RightMouse>"'

                local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
                menu.open(options, { mouse = true })
            end, {})
        end
    },
}
