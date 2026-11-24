# Typing interruptions from the keyboard touchpad

Tested on: ASUS Zenbook Duo UX8406CA, Omarchy 4.5.0, Hyprland 0.56.2,
detachable keyboard over Bluetooth (2026-11-24).

## Symptom

While typing, text suddenly stops going where expected:

- the text cursor jumps to another position in the same field, so the end of a
  word appears at the start (for example `ro okay ... que ra` instead of
  `okay ... que raro`), or
- keyboard focus moves to another window and the input is lost until the
  pointer is moved back.

The keyboard does not disconnect; the kernel log shows no HID removal.

## Cause

1. libinput's *disable while typing* only pairs a touchpad with an internal
   keyboard. The detachable keyboard is a Bluetooth device, so its touchpad
   stays active while typing and a palm tap becomes a click.
2. Omarchy defaults to `follow_mouse = 1`, so a small pointer movement onto
   another window also moves keyboard focus.

## Workaround

In `~/.config/hypr/input.lua`:

```lua
hl.config({
  input = {
    -- Focus changes only on click, so a brushed touchpad never steals typing.
    follow_mouse = 2,
  },
})

-- Palm taps on the keyboard touchpad no longer click; physical clicks still work.
hl.device({ name = "asus-zenbook-duo-keyboard-touchpad", tap_to_click = false })
```

Apply with `hyprctl reload` and check `hyprctl configerrors`.

How to revert: remove both settings and run `hyprctl reload`.
