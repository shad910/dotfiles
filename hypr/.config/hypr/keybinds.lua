-- keybinds.lua

local mainMod = "SUPER"
local ipc = "noctalia msg "

-- Applications
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("brave-origin --password-store=gnome-libsecret"))
hl.bind(mainMod .. " + H", hl.dsp.exec_cmd("helium --password-store=gnome-libsecret"))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("code"))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + ALT + T", hl.dsp.exec_cmd("gnome-text-editor")) -- moved from Super+Shift+T
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("nautilus"))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(ipc .. "panel-toggle launcher"))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("systemctl reboot"))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd("gdmflexiserver || loginctl lock-session"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("systemctl poweroff"))

-- Window management
hl.bind(mainMod .. " + W", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("hyprctl kill"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))                       -- toggle float/tile
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.float({ action = "enable" }))               -- force floating
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + CTRL + SHIFT + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))

-- Focus: Super + arrows
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Move the window to another tile (swap position, no resizing): Super + Shift + arrows
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.move({ direction = "down" }))

-- Resize (kept, moved to Super + Ctrl + arrows)
local resizeUnit = 20
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.resize({ x =  resizeUnit, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + left",  hl.dsp.window.resize({ x = -resizeUnit, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + up",    hl.dsp.window.resize({ x = 0, y = -resizeUnit, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + down",  hl.dsp.window.resize({ x = 0, y =  resizeUnit, relative = true }), { repeating = true })

-- Layout of the CURRENT workspace (uses helpers from display.lua)
local function set_layout(name)
    local ws = hl.get_active_workspace()
    if not ws then return end
    local id = tonumber(ws.id)
    if not id then return end
    ws_layouts[id] = name
    apply_workspace_rule(id)
end

-- Super+Shift+T: tiled mode (dwindle layout; also tiles the focused window if it was floating)
hl.bind(mainMod .. " + SHIFT + T", function()
    set_layout("dwindle")
    hl.dispatch(hl.dsp.window.float({ action = "disable" }))
end)

-- Super+Shift+N: niri-style mode (scrolling layout)
hl.bind(mainMod .. " + SHIFT + N", function()
    set_layout("scrolling")
end)

-- Super+N: workspace overview -> not available natively in Hyprland, see notes.
-- hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("<overview command>"))

-- Workspaces [1-10]
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Multimedia & brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Super+Space: real toggle between OpenBangla and English.
-- Check the engine name with:  ibus list-engine | grep -i bangla   (edit BANGLA below if it differs)
local BANGLA = "OpenBangla"
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(
    "if [ \"$(ibus engine)\" = \"" .. BANGLA .. "\" ]; then ibus engine xkb:us::eng; else ibus engine " .. BANGLA .. "; fi"
))