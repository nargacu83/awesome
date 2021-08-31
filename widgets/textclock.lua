local wibox = require("wibox")

local textclock = {
    format = "%a %d %b %H:%M",
    widget = wibox.widget.textclock,
    right = 6,
}

return textclock
