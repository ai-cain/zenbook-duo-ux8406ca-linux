# Vertical dual-screen layout

## Workaround record

```text
Tested on: ASUS Zenbook Duo UX8406CA
Kernel: 7.2.3-arch1-3
Omarchy: 4.0.3-1
Hyprland: 0.56.2-2
Applicability: Hyprland; the reusable Lua file follows Omarchy's config structure.

Problem: Automatic placement arranged the internal panels horizontally.
Cause: Generic automatic monitor placement does not know the physical chassis layout.
Workaround: Set both panel modes, scale and logical positions explicitly.
How to revert: Run ./uninstall.sh --layout or restore ~/.config/hypr/monitors.lua.
Upstream status: The updated kernel recognizes the UX8406CA, but physical
arrangement still needs local Hyprland policy.
```

The incorrect automatic result was logically `eDP-1` at `0x0` and `eDP-2` at
`1440x0`. The lower panel is physically below the upper panel.

At scale 2, each 2880×1800 panel occupies 1440×900 logical pixels. Therefore
the correct lower-panel origin is Y=900:

```lua
hl.monitor({
    output = "eDP-1",
    mode = "2880x1800@120",
    position = "0x0",
    scale = 2
})

hl.monitor({
    output = "eDP-2",
    mode = "2880x1800@120",
    position = "0x900",
    scale = 2
})
```

The global values must not force scale 3. The tested configuration uses
`GDK_SCALE=2`, a generic monitor fallback with scale `"auto"`, and the two
specific scale-2 rules. See [the reusable config](../configs/omarchy/monitors.lua).

Install it with `./install.sh --layout`, then check:

```bash
hyprctl reload
hyprctl configerrors
hyprctl monitors
```

Expected logical origins are `0x0` and `0x900`. Hyprland reports dimensions and
positions in logical pixels when scaling is active.

## 1920×1200 panel variant

Some UX8406CA units ship with 1920×1200 OLED panels (upper panel
`Samsung ATNA40CT06-0`), which only expose `1920x1200@60`. A hard-coded
`2880x1800@120` mode falls back to 1920×1200 while keeping scale 2 and
position `0x900`, which leaves a 300 px logical gap that the cursor cannot
cross. The packaged config therefore uses `mode = "preferred"`,
`scale = "auto"` and `position = "auto-down"` so the panels touch on both
variants (validated on 1920×1200: scale 1.5, lower panel at `0x800`).
On 2880×1800 units, `preferred` may select 60 Hz; set `2880x1800@120`
explicitly if 120 Hz is wanted.
