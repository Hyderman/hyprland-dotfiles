-- Pull in the wezterm API
local wezterm = require("wezterm")
-- This table will hold the configuration.
local config = {}
-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

if wezterm.target_triple == "x86_64-unknown-linux-gnu" then
    config.font = wezterm.font("FiraMono Nerd Font", { weight = "Regular", stretch = "Normal", style = "Normal" }) -- /usr/share/fonts/OTF/FiraMonoNerdFont-Regular.otf, FontConfig
elseif wezterm.target_triple == "x86_64-pc-windows-msvc" then
    config.adjust_window_size_when_changing_font_size = false
    config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
    config.default_prog = { "pwsh.exe" }
    config.font = wezterm.font("FiraCode NFM", { weight = "Medium", stretch = "Normal", style = "Normal" })
end
config.window_frame = {
    active_titlebar_bg = "#13131e",
    inactive_titlebar_bg = "#13131e",
}
config.color_scheme = 'Catppuccin Mocha'
config.colors = {
    tab_bar = {
        active_tab = {
            bg_color = "#1e1e2e",
            fg_color = "#cdd6f4"
        },
        inactive_tab = {
            bg_color = "#13131e",
            fg_color = "#cdd6f4"
        },
        new_tab = {
            bg_color = "#13131e",
            fg_color = "#cdd6f4"
        }
    }
}
config.keys = {
    {
        key = 'F',
        mods = 'SHIFT|ALT',
        action = wezterm.action.TogglePaneZoomState,
    },
    {
        key = 't',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.SpawnTab 'CurrentPaneDomain',
    },
    -- Create a new tab in the default domain
    -- {
    --     key = 't',
    --     mods = 'CTRL|ALT',
    --     action = wezterm.action.SpawnTab 'DefaultDomain',
    -- },
    {
        key = 'w',
        mods = 'SHIFT|ALT',
        action = wezterm.action.CloseCurrentPane { confirm = true },
    },
    {
        key = 'h',
        mods = 'CTRL|ALT',
        action = wezterm.action.AdjustPaneSize { 'Left', 5 },
    },
    {
        key = 'j',
        mods = 'CTRL|ALT',
        action = wezterm.action.AdjustPaneSize { 'Down', 5 },
    },
    {
        key = 'k',
        mods = 'CTRL|ALT',
        action = wezterm.action.AdjustPaneSize { 'Up', 5 }
    },
    {
        key = 'l',
        mods = 'CTRL|ALT',
        action = wezterm.action.AdjustPaneSize { 'Right', 5 },
    },
    {
        key = '_',
        mods = 'SHIFT|ALT',
        action = wezterm.action.SplitPane {
            direction = "Right",
            size = { Percent = 50 },
        },
    },
    {
        key = '+',
        mods = 'SHIFT|ALT',
        action = wezterm.action.SplitPane {
            direction = "Down",
            size = { Percent = 33 },
        },
    },
    {
        key = 'h',
        mods = 'SHIFT|ALT',
        action = wezterm.action.ActivatePaneDirection 'Left',
    },
    {
        key = 'l',
        mods = 'SHIFT|ALT',
        action = wezterm.action.ActivatePaneDirection 'Right',
    },
    {
        key = 'k',
        mods = 'SHIFT|ALT',
        action = wezterm.action.ActivatePaneDirection 'Up',
    },
    {
        key = 'j',
        mods = 'SHIFT|ALT',
        action = wezterm.action.ActivatePaneDirection 'Down',
    },

}
for i = 1, 8 do
  -- CTRL+ALT + number to activate that tab
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'ALT',
    action = wezterm.action.ActivateTab(i - 1),
  })
end

-- for i = 1, 8 do
--     -- CTRL+ALT + number to move to that position
--     table.insert(config.keys, {
--         key = tostring(i),
--         mods = 'CTRL|ALT',
--         action = wezterm.action.MoveTab(i - 1),
--     })
-- end

return config
