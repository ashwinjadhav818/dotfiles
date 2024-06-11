return {{
    'nvim-treesitter/nvim-treesitter',
    opts = {
        highlight = {
            enable = true,
            disable = {}
        },
        indent = {
            enable = true,
            disable = {}
        },
        ensure_installed = {"tsx", "fish", "json", "yaml", "css", "html", "lua", "markdown", "markdown_inline",
                            "python", "graphql", "regex", "typescript", "javascript", "java"},
        --- Automatically install missing parsers when entering buffer
        auto_install = true,

        autotag = {
            enable = true
        }
    }
}}
