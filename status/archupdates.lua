local awful = require("awful")

local interval = 3600

awful.widget.watch("checkupdates | wc -l", interval, function(_, stdout)
    local count = tonumber(stdout)
    awesome.emit_signal("status::archupdates", count)
end)
