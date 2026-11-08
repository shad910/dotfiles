-- autostart.lua

hl.on("hyprland.start", function()
    -- 1) Environment first, so everything started afterwards inherits it
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP GTK_IM_MODULE QT_IM_MODULE XMODIFIERS GLFW_IM_MODULE")
    hl.exec_cmd("systemctl --user --no-block start graphical-session.target")

    -- 2) Input method daemon (OpenBangla) BEFORE the shell/apps
    hl.exec_cmd("ibus-daemon -drx")

    -- 3) Shell
    hl.exec_cmd("noctalia")

    -- GTK / Libadwaita dark preferences
    hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'")
end)