return {
    -- Mason for managing LSP servers
    {
        'williamboman/mason.nvim',
        lazy = false,
        opts = {
            auto_install = true, -- Automatically install missing servers
        },
        config = true,
        keys = {
            { "<leader>lm",  "<cmd>Mason<cr>",                                    desc = "Mason" },
        }
    },
    { 
        "williamboman/mason-lspconfig.nvim"
    },
}
