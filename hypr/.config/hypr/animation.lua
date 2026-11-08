-- animation.lua
-- NOTE: `speed` is in deciseconds (1 = 100 ms) and LOWER = FASTER.
-- The old file used 10-25, i.e. 1.0-2.5 seconds per animation (Hyprland's own default is ~0.5s).
-- Only three things animate now, all ~0.2-0.25s. Everything else is off (saves GPU wakeups).

hl.curve("snap", { type = "bezier", points = { {0.16, 1}, {0.3, 1} } })

-- Root switch off; the leaves below are explicitly turned back on.
hl.animation({ leaf = "global", enabled = false, speed = 1, bezier = "snap" })

hl.animation({ leaf = "windows",    enabled = true, speed = 2.5, bezier = "snap", style = "popin 92%" })
hl.animation({ leaf = "fade",       enabled = true, speed = 2,   bezier = "snap" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 2.5, bezier = "snap", style = "fade" })