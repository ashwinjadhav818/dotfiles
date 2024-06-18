return {
    {
        'Exafunction/codeium.vim',
        config = function()
            -- Change '<C-g>' here to any keycode you like.
            vim.keymap.set('i', '<C-d>', function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
            vim.keymap.set('i', '<c-a>', function() return vim.fn['codeium#CycleCompletions'](1) end,
                { expr = true, silent = true })
            vim.keymap.set('i', '<c-p>', function() return vim.fn['codeium#CycleCompletions'](-1) end,
                { expr = true, silent = true })
            vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
        end
    },
}
