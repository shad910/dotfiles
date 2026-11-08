-- look_and_feel.lua
-- Battery-oriented: blur and shadows off (they cost the most on an iGPU).

hl.config({
    general = {
        gaps_in = 1,
        gaps_out = 0.5,
        border_size = 1,
        col = {
            active_border = { colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },
        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },

    decoration = {
        rounding = 8,
        rounding_power = 2,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        shadow = { enabled = false },
        blur   = { enabled = false },
    },

    animations = { enabled = true },

    dwindle = { preserve_split = true, force_split = 2 },
    master  = { new_status = "slave" },
    scrolling = { fullscreen_on_one_column = true },

    misc = {
        force_default_wallpaper = 0,      -- noctalia draws the wallpaper
        disable_hyprland_logo = true,
    },

    binds = { workspace_back_and_forth = true },

    input = {
        kb_layout = "us",
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = { natural_scroll = true },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})