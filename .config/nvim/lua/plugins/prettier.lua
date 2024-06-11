return {{
    "MunifTanjim/prettier.nvim",
    opts = {
        bin = 'prettierd', -- or `'prettier'` (v0.23.3+)
        filetypes = {"css", "graphql", "html", "javascript", "javascriptreact", "json", "less", "markdown", "scss","typescript", "typescriptreact", "yaml"}
    }
} -- Prettier plugin for Neovim's built-in LSP client
}
