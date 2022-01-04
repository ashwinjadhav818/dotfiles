-- This is an example chadrc file , its supposed to be placed in /lua/custom dir
-- lua/custom/chadrc.lua

local M = {}

-- make sure you maintain the structure of `core/default_config.lua` here,
-- example of changing theme:

---- UI -----

M.ui = {
  italic_comments = true,

  -- Change terminal bg to nvim theme's bg color so it'll match well
  -- For Ex : if you have onedark set in nvchad, set onedark's bg color on your terminal
  transparency = true
}


---- PLUGIN OPTIONS ----

M.plugins = {
  -- enable/disable plugins (false for disable)
  status = {
    colorizer = true, -- color RGB, HEX, CSS, NAME color codes
    dashboard = true,
  },
}


---- PLUGIN MAPPINGS ----

M.mappings.plugins = { 
  nvimtree = {
      toggle = "<leader>ee",
      focus = "<leader>ef",
  },
}

return M
