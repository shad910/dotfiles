-- display.lua

local internal = "eDP-1"
local external = "HDMI-A-1"
local res      = "1920x1080@60"
local scale    = "1.25"

-- With scale 1.25 the internal panel is 1920/1.25 = 1536 LOGICAL pixels wide.
-- Positions are in logical pixels, so the external monitor goes at 1536 (not 1920),
-- otherwise there is a dead gap the mouse can't cross.
local external_x = "1536x0"

----------------------------------------------------------------
-- Workspaces: 1-5 on the internal display, 6-10 on the external
-- One helper, used at startup AND by the layout keybinds
----------------------------------------------------------------
ws_layouts = {}  -- global on purpose: keybinds.lua writes to it (nil = default layout)

function apply_workspace_rule(i)
    local rule = { workspace = tostring(i), persistent = true, layout = ws_layouts[i] }
    if i <= 5 then
        rule.monitor = internal
    elseif i <= 10 then
        rule.monitor = external
    end
    hl.workspace_rule(rule)
end

for i = 1, 10 do apply_workspace_rule(i) end

----------------------------------------------------------------
-- Display modes (F1 cycles): 1 extend -> 2 mirror -> 3 external only -> 4 internal only
-- hyprctl keyword is rejected by Lua configs, so this calls hl.monitor() directly.
----------------------------------------------------------------
local display_mode = 1

local function apply_display_mode(m)
    if m == 1 then -- extend
        hl.monitor({ output = internal, mode = res, position = "0x0",       scale = scale, disabled = false })
        hl.monitor({ output = external, mode = res, position = external_x,  scale = scale, disabled = false })
    elseif m == 2 then -- mirror internal onto external
        hl.monitor({ output = external, mode = res, position = "0x0", scale = scale, disabled = false })
        hl.monitor({ output = internal, mode = res, position = "0x0", scale = scale, disabled = false, mirror = external })
    elseif m == 3 then -- external only
        hl.monitor({ output = external, mode = res, position = "0x0", scale = scale, disabled = false })
        hl.monitor({ output = internal, disabled = true })
    else -- internal only
        hl.monitor({ output = internal, mode = res, position = "0x0", scale = scale, disabled = false })
        hl.monitor({ output = external, disabled = true })
    end
end

apply_display_mode(1) -- default at login

hl.bind("F1", function()
    display_mode = display_mode % 4 + 1
    apply_display_mode(display_mode)
end)