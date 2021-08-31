local awful = require("awful")
local wibox = require("wibox")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local widget_padding = 8
local wibar_height = 35

-- Widget imports
local mytaglist = require("widgets.taglist")
local mytasklist = require("widgets.tasklist")
local mysystray = require("widgets.systray")
local mybattery = require("widgets.battery")
local mymemory = require("widgets.memory")
local mytextclock = require("widgets.textclock")

local wibar = {}

function wibar.get(s)
    local mywibox = awful.wibar({
        position = "top",
        screen = s,
        height = dpi(wibar_height)
    })

    local taglist = mytaglist.get(s)
    local tasklist = mytasklist.get(s)
    
    local left = {
        layout = wibox.layout.fixed.horizontal,
        taglist,
        tasklist
    }

    local right = {
        layout = wibox.layout.fixed.horizontal,
        mysystray,
        mymemory,
        mybattery,
        mytextclock
    }

    -- Add widgets to the wibox
    mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            left,
            right = 10,
            widget = wibox.container.margin
        },
        { -- Middle widgets
            layout = wibox.layout.align.horizontal
        },
        { -- Right widgets
            right,
            widget = wibox.container.margin
        }
    }

    return mywibox
end

return wibar
