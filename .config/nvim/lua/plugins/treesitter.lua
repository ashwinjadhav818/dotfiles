return { {
    'nvim-treesitter/nvim-treesitter',
    config = function()
        require("nvim-treesitter.configs").setup({
            highlight = {
                enable = true,
            },
            indent = {
                enable = true,
                disable = {}
            },
            ensure_installed = { "tsx", "fish", "json", "yaml", "css", "html", "lua", "markdown", "markdown_inline",
                "python", "graphql", "regex", "typescript", "javascript", "java" },
            --- Automatically install missing parsers when entering buffer
            auto_install = true,

            autotag = {
                enable = true
            }
        })
    end
} }
