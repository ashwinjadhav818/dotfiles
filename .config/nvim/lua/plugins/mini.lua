return {
    {
        "echasnovski/mini.nvim",
        version = false,
        config = function ()
            require("mini.basics").setup({
                mappings = {
                    windows = true,
                    move_with_alt = true,
                }
            })
            require("mini.comment").setup()
        end
    },
}
