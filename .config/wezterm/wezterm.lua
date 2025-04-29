local wezterm = require("wezterm")
local act = wezterm.action

local pwsh_path =
"C:\\Users\\Ashwin\\AppData\\Local\\Microsoft\\WindowsApps\\Microsoft.PowerShell_8wekyb3d8bbwe\\pwsh.exe"

local config = {}
if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- Settings
config.default_prog = { pwsh_path, "-NoProfileLoadTime", "-NoLogo" }

-- UI
config.window_decorations = "RESIZE"
config.color_scheme = "tokyonight"
config.window_background_opacity = 0.7
config.win32_system_backdrop = "Acrylic"
-- config.front_end = "WebGpu"
-- config.colors = {
-- 	background = "#000",
-- }
config.inactive_pane_hsb = { -- Dim inactive panes
    saturation = 0.8,
    brightness = 0.6,
}

-- Font
config.font = wezterm.font("MonoLisa")
config.font_size = 12

-- Keybindings
Leader = "CTRL"
LeaderShift = "CTRL|SHIFT"
config.keys = {
    { key = "c", mods = LeaderShift, action = act.ActivateCopyMode },
    { key = "p", mods = Leader,      action = act.ActivateCommandPalette },

    -- Pane keybindings
    { key = "z", mods = Leader,      action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = "x", mods = Leader,      action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "a", mods = Leader,      action = act.ActivatePaneDirection("Left") },
    { key = "s", mods = Leader,      action = act.ActivatePaneDirection("Down") },
    { key = "w", mods = Leader,      action = act.ActivatePaneDirection("Up") },
    { key = "d", mods = Leader,      action = act.ActivatePaneDirection("Right") },
    { key = "q", mods = Leader,      action = act.CloseCurrentPane({ confirm = true }) },
    -- { key = "z", mods = Leader,      action = act.TogglePaneZoomState },
    { key = "o", mods = Leader,      action = act.RotatePanes("Clockwise") },
    -- We can make separate keybindings for resizing panes
    -- But Wezterm offers custom "mode" in the name of "KeyTable"
    { key = "r", mods = Leader,      action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }) },

    -- Tab keybindings
    { key = "t", mods = Leader,      action = act.SpawnTab("CurrentPaneDomain") },
    { key = "[", mods = Leader,      action = act.ActivateTabRelative(-1) },
    { key = "]", mods = Leader,      action = act.ActivateTabRelative(1) },
    { key = "n", mods = Leader,      action = act.ShowTabNavigator },
    {
        key = "e",
        mods = Leader,
        action = act.PromptInputLine({
            description = wezterm.format({
                { Attribute = { Intensity = "Bold" } },
                { Foreground = { AnsiColor = "Fuchsia" } },
                { Text = "Rename Tab Title:" },
            }),
            action = wezterm.action_callback(function(window, pane, line)
                if line then
                    window:active_tab():set_title(line)
                end
            end),
        }),
    },
    -- Key table for moving tabs around
    { key = "m", mods = Leader,      action = act.ActivateKeyTable({ name = "move_tab", one_shot = false }) },

    -- Lastly, workspace
    { key = "f", mods = LeaderShift, action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
    -- I can use the tab navigator (LDR t), but I also want to quickly navigate tabs with index
}
for i = 1, 9 do
    table.insert(config.keys, {
        key = tostring(i),
        mods = Leader,
        action = act.ActivateTab(i - 1),
    })
end
config.key_tables = {
    resize_pane = {
        { key = "a",      action = act.AdjustPaneSize({ "Left", 1 }) },
        { key = "s",      action = act.AdjustPaneSize({ "Down", 1 }) },
        { key = "w",      action = act.AdjustPaneSize({ "Up", 1 }) },
        { key = "d",      action = act.AdjustPaneSize({ "Right", 1 }) },
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
    },
}
wezterm.on("format-window-title", function()
    local title = "WezTerm"
    return title
end)

-- Tab bar
config.integrated_title_buttons = { "Close" }

return config
