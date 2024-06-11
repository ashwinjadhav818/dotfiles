return {{
    "folke/noice.nvim",
    config = function()
        require("noice").setup({
            -- add any options here
            routes = {{
                filter = {
                    event = 'msg_show',
                    any = {{
                        find = '%d+L, %d+B'
                    }, {
                        find = '; after #%d+'
                    }, {
                        find = '; before #%d+'
                    }, {
                        find = '%d fewer lines'
                    }, {
                        find = '%d more lines'
                    }}
                },
                opts = {
                    skip = true
                }
            }}
        })
    end,
    dependencies = { -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim", -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify"}
}}
