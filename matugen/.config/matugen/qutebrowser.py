palette = {
    "background": "{{colors.surface.default.hex}}",
    "background_alt": "{{colors.surface_container.default.hex}}",
    "background_selected": "{{colors.surface_container_high.default.hex}}",
    "background_dim": "{{colors.surface_container_highest.default.hex}}",

    "foreground": "{{colors.on_surface.default.hex}}",
    "foreground_muted": "{{colors.on_surface_variant.default.hex}}",

    "red": "{{colors.error.default.hex}}",
    "orange": "{{colors.tertiary_fixed.default.hex}}",
    "yellow": "{{colors.primary_fixed.default.hex}}",
    "green": "{{colors.primary.default.hex}}",
    "blue": "{{colors.secondary_fixed.default.hex}}",
    "magenta": "{{colors.secondary.default.hex}}",
    "cyan": "{{colors.tertiary.default.hex}}",
    "teal": "{{colors.primary_fixed_dim.default.hex}}",

    "black": "{{colors.surface_bright.default.hex}}",
}

# --- Completion ---
c.colors.completion.fg = palette["foreground"]
c.colors.completion.odd.bg = palette["background_alt"]
c.colors.completion.even.bg = palette["background"]
c.colors.completion.category.fg = palette["blue"]
c.colors.completion.category.bg = palette["background_alt"]
c.colors.completion.category.border.top = palette["black"]
c.colors.completion.category.border.bottom = palette["black"]
c.colors.completion.item.selected.fg = palette["cyan"]
c.colors.completion.item.selected.bg = palette["background_selected"]
c.colors.completion.item.selected.border.top = palette["background_selected"]
c.colors.completion.item.selected.border.bottom = palette["background_selected"]
c.colors.completion.item.selected.match.fg = palette["orange"]
c.colors.completion.match.fg = palette["yellow"]
c.colors.completion.scrollbar.fg = palette["foreground"]
c.colors.completion.scrollbar.bg = palette["background"]

# --- Context Menu ---
c.colors.contextmenu.disabled.bg = palette["background_alt"]
c.colors.contextmenu.disabled.fg = palette["foreground_muted"]
c.colors.contextmenu.menu.bg = palette["background"]
c.colors.contextmenu.menu.fg = palette["foreground"]
c.colors.contextmenu.selected.bg = palette["background_selected"]
c.colors.contextmenu.selected.fg = palette["foreground"]

# --- Statusbar ---
c.colors.statusbar.normal.fg = palette["green"]
c.colors.statusbar.normal.bg = palette["background"]
c.colors.statusbar.insert.fg = palette["background"]
c.colors.statusbar.insert.bg = palette["blue"]
c.colors.statusbar.passthrough.fg = palette["background"]
c.colors.statusbar.passthrough.bg = palette["teal"]
c.colors.statusbar.command.fg = palette["foreground"]
c.colors.statusbar.command.bg = palette["background"]
c.colors.statusbar.url.fg = palette["foreground"]
c.colors.statusbar.url.error.fg = palette["red"]
c.colors.statusbar.url.hover.fg = palette["cyan"]
c.colors.statusbar.url.success.http.fg = palette["green"]
c.colors.statusbar.url.success.https.fg = palette["blue"]

# --- Tabs ---
c.colors.tabs.bar.bg = palette["background"]
c.colors.tabs.odd.fg = palette["foreground"]
c.colors.tabs.odd.bg = palette["background_selected"]
c.colors.tabs.even.fg = palette["foreground"]
c.colors.tabs.even.bg = palette["background_selected"]
c.colors.tabs.selected.odd.fg = palette["foreground"]
c.colors.tabs.selected.odd.bg = palette["background_dim"]
c.colors.tabs.selected.even.fg = palette["foreground"]
c.colors.tabs.selected.even.bg = palette["background_dim"]

# --- Messages ---
c.colors.messages.error.fg = palette["red"]
c.colors.messages.error.bg = palette["background"]
c.colors.messages.warning.fg = palette["orange"]
c.colors.messages.warning.bg = palette["background"]
c.colors.messages.info.fg = palette["cyan"]
c.colors.messages.info.bg = palette["background"]
