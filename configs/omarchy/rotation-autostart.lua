-- BEGIN ux8406ca-linux rotation
-- Rotate and arrange both UX8406CA panels from the lid accelerometer.
o.launch_on_start((os.getenv("HOME") or "") .. "/.local/bin/ux8406ca-rotation")
-- END ux8406ca-linux rotation
