return {
    {
        'nvim-telescope/telescope.nvim',
        config = function()
            local telescope = require("telescope")

            telescope.setup({
                builtin = {
                    find_files = {
                        opts = {
                            hidden = "true"
                        }
                    } }
            })
        end,
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
}
