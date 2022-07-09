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
local mymemory = require("widgets.memory")
local myarchupdates = require("widgets.archupdates")
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

    -- Add widgets to the wibox
    mywibox:setup {
        layout = wibox.layout.align.horizontal,
        expand = "none",
        { -- Left widgets
            widget = wibox.container.margin,
            left = 10,

            tasklist,
        },
        { -- Middle widgets
            widget = wibox.container.place,
            content_fill_vertical = true,
            {
                widget = wibox.container.margin,
                layout = wibox.layout.stack,
                mytextclock,
                {
                    widget = wibox.container.place,
                    valign = "bottom",
                    forced_height = taglist.tag_height,
                    taglist
                },
            }
        },
        { -- Right widgets
            widget = wibox.container.place,
            h_align = "right",
            {
                widget = wibox.container.margin,
                right = 10,
                {
                    widget = wibox.container.place,
                    layout = wibox.layout.fixed.horizontal,
                    spacing = 5,

                    mymemory,
                    myarchupdates,
                    mysystray,
                }
            }
        }
    }

    return mywibox
end

return wibar
