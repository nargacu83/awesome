local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local taglist = {}

local tag_width = 30
local tag_height = 6

local taglist_buttons = gears.table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)


function taglist.get(s)
    local widget = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        widget_template = {
            id = 'background_role',
            widget = wibox.container.background,
            {
                widget = wibox.container.margin,
                top = dpi(tag_height/2),
                bottom = dpi(tag_height/2),
                left = dpi(tag_width/2),
                right = dpi(tag_width/2)
            }
        },
        buttons = taglist_buttons
    }

    return widget
end

return taglist
