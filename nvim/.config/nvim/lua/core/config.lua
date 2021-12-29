local M = {}

M.options = {
   -- custom = {}
   -- general nvim/vim options , check :h optionname to know more about an option

   clipboard = "unnamedplus",
   cmdheight = 1,
   ruler = false,
   hidden = true,
   ignorecase = true,
   smartcase = true,
   mapleader = " ",
   mouse = "a",
   number = true,
   numberwidth = 2,
   relativenumber = false,
   expandtab = true,
   shiftwidth = 2,
   smartindent = true,
   tabstop = 8,
   timeoutlen = 400,
   updatetime = 250,
   undofile = true,
   fillchars = { eob = " " },
}

---- UI -----

M.ui = {
   hl_override = "", -- path of your file that contains highlights
   italic_comments = false,
   theme = "onedark-deep", 

   -- Change terminal bg to nvim theme's bg color so it'll match well
   transparency = true,
}

---- PLUGIN OPTIONS ----

M.plugins = {
   -- enable/disable plugins (false for disable)
   status = {
      blankline = true, -- indentline stuff
      bufferline = true, -- manage and preview opened buffers
      colorizer = true, -- color RGB, HEX, CSS, NAME color codes
      comment = true, -- easily (un)comment code, language aware
      dashboard = true,
      better_escape = true, -- map to <ESC> with no lag
      feline = true, -- statusline
      gitsigns = true,
      lspsignature = true, -- lsp enhancements
      telescope_media = true,
      vim_matchup = true, -- improved matchit
      cmp = true,
      nvimtree = true,
      autopairs = true,
   },
   options = {
      autopairs = { loadAfter = "nvim-cmp" },
      lspconfig = {
         setup_lspconf = "", -- path of file containing setups of different lsps
      },
      nvimtree = {
         enable_git = 0,

         ui = {
            allow_resize = true,
            side = "left",
            width = 25,
            hide_root_folder = true,
         },
      },
      luasnip = {
         snippet_path = {},
      },
      statusline = {
         -- hide, show on specific filetypes
         hidden = {
            "help",
            "dashboard",
            "NvimTree",
            "terminal",
         },
         shown = {},

         -- truncate statusline on small screens
         shortline = true,
         style = "default", -- default, round , slant , block , arrow
      },
      esc_insertmode_timeout = 300,
   },
   default_plugin_config_replace = {},
}

-- Don't use a single keymap twice

--- MAPPINGS ----

-- non plugin
M.mappings = {
   -- custom = {}, -- custom user mappings

   misc = {
      close_buffer = "<leader>q",
      save_file = "<leader>w", -- save file using :w
      cheatsheet = "<leader>ch",
      copy_whole_file = "<C-a>", -- copy all contents of current buffer
      line_number_toggle = "<leader>n", -- toggle line number
      update_nvchad = "<leader>uu",
      new_buffer = "<S-t>",
      new_tab = "<C-t>b",
   },

   -- navigation in insert mode, only if enabled in options

   insert_nav = {
      backward = "<C-h>",
      end_of_line = "<C-e>",
      forward = "<C-l>",
      next_line = "<C-k>",
      prev_line = "<C-j>",
      beginning_of_line = "<C-a>",
   },

   -- better window movement
   window_nav = {
      moveLeft = "<C-h>",
      moveRight = "<C-l>",
      moveUp = "<C-k>",
      moveDown = "<C-j>",
   },

   -- terminal related mappings
   terminal = {
      -- multiple mappings can be given for esc_termmode, esc_hide_termmode

      -- get out of terminal mode
      esc_termmode = { "jk" },

      -- get out of terminal mode and hide it
      esc_hide_termmode = { "JK" },
      -- show & recover hidden terminal buffers in a telescope picker
      pick_term = "<leader>W",

      -- spawn terminals
      new_horizontal = "<leader>h",
      new_vertical = "<leader>v",
      new_window = "<leader>w",
   },
}

-- plugins related mappings

M.mappings.plugins = {
   bufferline = {
      next_buffer = "<TAB>",
      prev_buffer = "<S-Tab>",
   },
   comment = {
      toggle = "<leader>/",
   },

   dashboard = {
      bookmarks = "<leader>bm",
      new_file = "<leader>fn", -- basically create a new buffer
      open = "<leader>db", -- open dashboard
      session_load = "<leader>l",
      session_save = "<leader>s",
   },

   -- map to <ESC> with no lag
   better_escape = { -- <ESC> will still work
      esc_insertmode = { "jk" }, -- multiple mappings allowed
   },

   lspconfig = {
      declaration = "gD",
      definition = "gd",
      hover = "K",
      implementation = "gi",
      signature_help = "gk",
      add_workspace_folder = "<leader>wa",
      remove_workspace_folder = "<leader>wr",
      list_workspace_folders = "<leader>wl",
      type_definition = "<leader>D",
      rename = "<leader>rn",
      code_action = "<leader>ca",
      references = "gr",
      float_diagnostics = "ge",
      goto_prev = "[d",
      goto_next = "]d",
      set_loclist = "<leader>q",
      formatting = "<leader>fm",
   },

   nvimtree = {
      toggle = "<C-e>",
      focus = "<C-b>",
   },


   telescope = {
      buffers = "<leader>fb",
      find_files = "<leader>ff",
      find_hiddenfiles = "<leader>fa",
      git_commits = "<leader>cm",
      git_status = "<leader>gt",
      help_tags = "<leader>fh",
      live_grep = "<leader>fw",
      oldfiles = "<leader>fo",
      themes = "<leader>th", 

      telescope_media = {
         media_files = "<leader>fp",
      },
   },
}

return M
