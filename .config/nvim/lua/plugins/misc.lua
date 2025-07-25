return {
    { "xiyaowong/transparent.nvim" },
    { "sitiom/nvim-numbertoggle" },
    {
        "luckasRanarison/tailwind-tools.nvim",
        name = "tailwind-tools",
        build = ":UpdateRemotePlugins",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "neovim/nvim-lspconfig", -- optional
        },
        opts = {}                    -- your configuration
    }
}
