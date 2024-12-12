return {
    -- Mason for managing LSP servers
    {
        'williamboman/mason.nvim',
        lazy = false,
        opts = {
            auto_install = true, -- Automatically install missing servers
        },
        config = true,
    },
}
