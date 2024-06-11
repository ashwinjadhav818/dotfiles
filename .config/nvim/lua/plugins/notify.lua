return {{
    "rcarriga/nvim-notify",
    config = function()
        require("notify").setup({
            enabled = false
        })
    end
}}
