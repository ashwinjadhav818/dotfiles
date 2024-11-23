return {
    { "nvzone/volt", lazy = true },
    {
        "nvzone/menu",
        lazy = true,
        config = function()
            local menu = require("menu")

            menu()
        end
    },
}
