-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all

local omarchy_gdk_scale = 2
local omarchy_monitor_scale = "auto"

hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))
hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = omarchy_monitor_scale
})

-- ASUS Zenbook Duo UX8406CA ships with either 2880x1800 or 1920x1200 OLED panels.
-- "preferred" + "auto" scale + "auto-down" keep the panels touching on both.

-- ASUS Zenbook Duo UX8406CA: upper display
hl.monitor({
    output = "eDP-1",
    mode = "preferred",
    position = "0x0",
    scale = "auto"
})

-- ASUS Zenbook Duo UX8406CA: lower display
hl.monitor({
    output = "eDP-2",
    mode = "preferred",
    position = "auto-down",
    scale = "auto"
})

-- Map each panel's touchscreen and stylus to its own display.
for _, d in ipairs({ "elan9008:00-04f3:4445", "elan9008:00-04f3:4445-stylus" }) do
    hl.device({ name = d, output = "eDP-1" })
end
for _, d in ipairs({ "elan9009:00-04f3:4446", "elan9009:00-04f3:4446-stylus" }) do
    hl.device({ name = d, output = "eDP-2" })
end

-- F8 on the ASUS keyboard sends SUPER + P (the Windows display-switch shortcut):
-- swap the workspaces shown on the upper and lower displays.
o.rebind("SUPER + P", "Swap upper and lower displays",
    hl.dsp.workspace.swap_monitors({ monitor1 = "eDP-1", monitor2 = "eDP-2" }))

-- Over Bluetooth the same F8 key sends Pause instead of SUPER + P.
o.bind("Pause", "Swap upper and lower displays",
    hl.dsp.workspace.swap_monitors({ monitor1 = "eDP-1", monitor2 = "eDP-2" }))
