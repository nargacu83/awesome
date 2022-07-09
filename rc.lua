-- Original config by dmun: https://github.com/dmun/awesome

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")

-- Notification library
local menubar = require("menubar")

local wibar = require("widgets.wibar")
local json = require("util.json")
local keys = require("keys")

-- Notify with dunst
function notify(title, description)
    awful.spawn("notify-send \"" .. title .. "\" \"" .. description .."\"")
end

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    awful.spawn("notify-send \"Oops, there were errors during startup!\" \"" .. awesome.startup_errors .."\"")
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        awful.spawn("notify-send \"Oops, an error happened!\" \"" .. tostring(err) .."\"")

        in_error = false
    end)
end
-- }}}

-- Get the system locale and apply it to awesome
os.setlocale(os.getenv("LANG"))

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
local theme_path = string.format("~/.config/awesome/theme/theme.lua")
beautiful.init(theme_path)

-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Layouts.
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.max,
}
-- }}}

-- {{{ Menu
-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

awful.screen.connect_for_each_screen(function(s)
    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4" }, s, awful.layout.layouts[1])

    wibar.get(s)
end)

root.keys(keys.globalkeys)
awful.rules.rules = require("rules")

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

client.connect_signal("property::maximized", function(c)
    if not c.maximized then return end
    c.maximized = false
end)

client.connect_signal("property::minimized", function(c)
    if not c.minimized then return end
    c.minimized = false
end)

client.connect_signal("property::floating", function(c)
    if c.fullscreen then return end
    if c.floating then
        c.ontop = true
    else
        c.ontop = false
    end
end)

tag.connect_signal("property::layout", function(t)
    update_clients_gaps(t)
end)

tag.connect_signal("property::selected", function(t)
    update_clients_gaps(t)
end)

-- Enable sloppy focus, so that focus follows mouse.
-- client.connect_signal("mouse::enter", function(c)
--     c:emit_signal("request::activate", "mouse_enter", {raise = false})
-- end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus c:raise() end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

function update_clients_gaps(t)
    if t.layout.name == "max" then
        for _, c in pairs(t.screen.clients) do
            if not c.floating or c.maximized then
                c.border_width = 0
                beautiful.gap_single_client  = false
            end
        end
    else
        for _, c in pairs(t.screen.clients) do
            if not c.floating or c.maximized then
                c.border_width = beautiful.border_width
                beautiful.gap_single_client  = true
            end
        end
    end
end

function change_client_state(state)
    client.focus.ontop = false
    client.focus.fullscreen = false
    client.focus.maximized = false
    client.focus.minimized = false
    client.focus.floating = false
    if state == "floating" or state == "stacking" then
        client.focus.floating = true
        client.focus.ontop = true
    elseif state == "maximized" then
        client.focus.maximized = true
        client.focus.ontop = true
    elseif state == "fullscreen" then
        client.focus.fullscreen = true
        client.focus.ontop = true
    end
end

--- Autostart
awful.spawn.with_shell("~/.config/awesome/autostart.sh")

-- Run garbage collector regularly to prevent memory leaks
gears.timer {
    timeout = 30,
    autostart = true,
    callback = function() collectgarbage() end
}
