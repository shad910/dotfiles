-- environment_variables.lua

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- OpenBangla / IBus
hl.env("GTK_IM_MODULE", "ibus")
hl.env("QT_IM_MODULE", "ibus")
hl.env("XMODIFIERS", "@im=ibus")
hl.env("GLFW_IM_MODULE", "ibus") -- kitty needs this one for IBus input

-- GTK dark overrides
hl.env("GTK_THEME", "Adwaita:dark")
hl.env("ADW_DISABLE_PORTAL", "0")