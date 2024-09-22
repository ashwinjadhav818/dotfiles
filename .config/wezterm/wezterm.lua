local wezterm = require "wezterm"
local act = wezterm.action

local pwsh_path =
"C:\\Users\\Ashwin\\AppData\\Local\\Microsoft\\WindowsApps\\Microsoft.PowerShell_8wekyb3d8bbwe\\pwsh.exe"

local config = {}
if wezterm.config_builder then config = wezterm.config_builder() end

-- Settings
config.default_prog = { pwsh_path, "-NoProfileLoadTime", "-NoLogo" }

-- UI
config.window_decorations = "RESIZE"
config.color_scheme = "tokyonight"
config.window_background_opacity = 0.5
config.win32_system_backdrop = "Acrylic"
config.colors = {
    background = "#000",
}
config.inactive_pane_hsb = { -- Dim inactive panes
    saturation = 0.8,
    brightness = 0.6
}

-- Font
config.font = wezterm.font "IosevkaCode Nerd Font"
config.font_size = 12

-- Keybindings
Leader = "CTRL"
LeaderShift = "CTRL|SHIFT"
config.keys = {
    { key = "c", mods = LeaderShift, action = act.ActivateCopyMode },
    { key = "p", mods = Leader,      action = act.ActivateCommandPalette },

    -- Pane keybindings
    { key = "z", mods = Leader,      action = act.SplitVertical { domain = "CurrentPaneDomain" } },
    { key = "x", mods = Leader,      action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
    { key = "a", mods = Leader,      action = act.ActivatePaneDirection("Left") },
    { key = "s", mods = Leader,      action = act.ActivatePaneDirection("Down") },
    { key = "w", mods = Leader,      action = act.ActivatePaneDirection("Up") },
    { key = "d", mods = Leader,      action = act.ActivatePaneDirection("Right") },
    { key = "q", mods = Leader,      action = act.CloseCurrentPane { confirm = true } },
    -- { key = "z", mods = Leader,      action = act.TogglePaneZoomState },
    { key = "o", mods = Leader,      action = act.RotatePanes "Clockwise" },
    -- We can make separate keybindings for resizing panes
    -- But Wezterm offers custom "mode" in the name of "KeyTable"
    { key = "r", mods = Leader,      action = act.ActivateKeyTable { name = "resize_pane", one_shot = false } },

    -- Tab keybindings
    { key = "t", mods = Leader,      action = act.SpawnTab("CurrentPaneDomain") },
    { key = "[", mods = Leader,      action = act.ActivateTabRelative(-1) },
    { key = "]", mods = Leader,      action = act.ActivateTabRelative(1) },
    { key = "n", mods = Leader,      action = act.ShowTabNavigator },
    {
        key = "e",
        mods = Leader,
        action = act.PromptInputLine {
            description = wezterm.format {
                { Attribute = { Intensity = "Bold" } },
                { Foreground = { AnsiColor = "Fuchsia" } },
                { Text = "Rename Tab Title:" },
            },
            action = wezterm.action_callback(function(window, pane, line)
                if line then
                    window:active_tab():set_title(line)
                end
            end),

        }
    },
    -- Key table for moving tabs around
    { key = "m", mods = Leader,      action = act.ActivateKeyTable { name = "move_tab", one_shot = false } },

    -- Lastly, workspace
    { key = "f", mods = LeaderShift, action = act.ShowLauncherArgs { flags = "FUZZY|WORKSPACES" } },
    -- I can use the tab navigator (LDR t), but I also want to quickly navigate tabs with index
}
for i = 1, 9 do
    table.insert(config.keys, {
        key = tostring(i),
        mods = Leader,
        action = act.ActivateTab(i - 1)
    })
end
config.key_tables = {
    resize_pane = {
        { key = "a",      action = act.AdjustPaneSize { "Left", 1 } },
        { key = "s",      action = act.AdjustPaneSize { "Down", 1 } },
        { key = "w",      action = act.AdjustPaneSize { "Up", 1 } },
        { key = "d",      action = act.AdjustPaneSize { "Right", 1 } },
        { key = "Escape", action = "PopKeyTable" },
        { key = "Enter",  action = "PopKeyTable" },
    },
    move_tab = {
        { key = "a",      action = act.MoveTabRelative(-1) },
        { key = "s",      action = act.MoveTabRelative(-1) },
        { key = "w",      action = act.MoveTabRelative(1) },
        { key = "d",      action = act.MoveTabRelative(1) },
        { key = "Escape", action = "PopKeyTable" },
        { key = "Enter",  action = "PopKeyTable" },
    }
}
wezterm.on('format-window-title', function()
    local title = 'WezTerm'
    return title
end)

-- Tab bar
-- Retro
config.use_fancy_tab_bar = false
config.status_update_interval = 1000
config.tab_bar_at_bottom = false
wezterm.on("update-status", function(window, pane)
    -- Workspace name
    local stat = window:active_workspace()
    local stat_color = "#f7768e"
    -- It's a little silly to have workspace name all the time
    -- Utilize this to display LDR or current key table name
    if window:active_key_table() then
        stat = window:active_key_table()
        stat_color = "#7dcfff"
    end
    if window:leader_is_active() then
        stat = "LDR"
        stat_color = "#bb9af7"
    end

    local basename = function(s)
        -- Nothing a little regex can't fix
        return string.gsub(s, "(.*[/\\])(.*)", "%2")
    end

    -- Current working directory
    local cwd = pane:get_current_working_dir()
    if cwd then
        if type(cwd) == "userdata" then
            -- Wezterm introduced the URL object in 20240127-113634-bbcac864
            cwd = basename(cwd.file_path)
        else
            -- 20230712-072601-f4abf8fd or earlier version
            cwd = basename(cwd)
        end
    else
        cwd = ""
    end

    -- Current command
    local cmd = pane:get_foreground_process_name()
    -- CWD and CMD could be nil (e.g. viewing log using Ctrl-Alt-l)
    cmd = cmd and basename(cmd) or ""

    -- Left status (left of the tab line)
    window:set_left_status(wezterm.format({
        { Foreground = { Color = stat_color } },
        { Text = "  " },
        { Text = wezterm.nerdfonts.oct_table .. "  " .. stat },
        { Text = " |" },
    }))

    -- Right status
    window:set_right_status(wezterm.format({
        -- Wezterm has a built-in nerd fonts
        -- https://wezfurlong.org/wezterm/config/lua/wezterm/nerdfonts.html
        { Text = wezterm.nerdfonts.md_folder .. "  " .. cwd },
        { Text = " | " },
        { Foreground = { Color = "#e0af68" } },
        { Text = wezterm.nerdfonts.fa_code .. "  " .. cmd },
        "ResetAttributes",
        { Text = " | " },
    }))
end)

return config
