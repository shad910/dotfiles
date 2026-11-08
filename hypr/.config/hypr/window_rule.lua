-- window_rule.lua

hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    no_focus = true,
})

hl.window_rule({
    name = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move = "20 monitor_h-120",
    float = true,
})

-- OpenBangla / IBus suggestion popup: floating and never takes focus.
-- Verify the class with:  hyprctl clients | grep -i -B2 -A8 ibus
hl.window_rule({
    name = "ime-popup",
    match = { class = "^(ibus-ui-gtk3|ibus-extension-gtk3|ibus-ui-emojier)$" },
    float = true,
    no_focus = true,
})

-- Small utilities that should always float. Add classes from `hyprctl clients`.
hl.window_rule({
    name = "float-utilities",
    match = { class = "^(org.pulseaudio.pavucontrol|pavucontrol|nm-connection-editor|blueman-manager|org.gnome.Calculator|polkit-gnome-authentication-agent-1)$" },
    float = true,
})