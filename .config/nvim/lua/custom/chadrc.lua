-- IMPORTANT NOTE : This is the user config, can be edited. Will be preserved if updated with internal updater
-- This file is for NvChad options & tools, custom settings are split between here and 'lua/custom/init.lua'

local M = {}
M.options, M.ui, M.mappings, M.plugins = {}, {}, {}, {}

-- NOTE: To use this, make a copy with `cp example_chadrc.lua chadrc.lua`

--------------------------------------------------------------------

-- To use this file, copy the structure of `core/default_config.lua`,
-- examples of setting relative number & changing theme:

M.options = {
  -- custom = {}
  -- general nvim/vim options , check :h optionname to know more about an option


  -- relativenumber = true,
}

---- UI -----

M.ui = {
  theme = "onedark-deep",
  transparency = true,
}

-- NvChad included plugin options & overrides
M.plugins = {
   options = {
      --   lspconfig = {
      --    path of file containing setups of different lsps (ex : "custom.plugins.lspconfig"), read the docs for more info
      --    setup_lspconf = "",
      --   },
   },
   status = {
    dashboard = true, -- NeoVim 'home screen' on open
    colorizer = true, -- color RGB, HEX, CSS, NAME color codes
    telescope_media = true, -- media previews within telescope finders
   },
   -- To change the Packer `config` of a plugin that comes with NvChad,
   -- add a table entry below matching the plugin github name
   --              '-' -> '_', remove any '.lua', '.nvim' extensions
   -- this string will be called in a `require`
   --              use "(custom.configs).my_func()" to call a function
   --              use "custom.blankline" to call a file
   default_plugin_config_replace = {},
}

M.mappings = {
  misc = {
    close_buffer = "<leader>q",
    save_file = "<leader>w", -- save file using :w
  },

  -- terminal related mappings
   terminal = {
      -- multiple mappings can be given for esc_termmode, esc_hide_termmode

      -- spawn terminals
      new_window = "<leader>t",
   },

}

M.mappings.plugins = {
  -- file explorer/tree
  nvimtree = {
    toggle = "<C-e>",
    focus = "<C-b>",
  },
}

return M
