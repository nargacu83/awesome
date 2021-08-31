local awful = require("awful")
local beautiful = require("beautiful")
local keys = require("keys")

local M = {}

M = {
	-- All clients will match this rule.
	{ rule = { },
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = clientkeys,
			buttons = keys.clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap+awful.placement.no_offscreen
		}
	},

	-- Floating clients.
	{ rule_any = {
		instance = {
			"DTA",  -- Firefox addon DownThemAll.
			"copyq",  -- Includes session name in class.
			"pinentry",
		},
		class = {
			"Arandr",
			"Blueman-manager",
			"Gpick",
			"Kruler",
			"MessageWin",  -- kalarm.
			"Sxiv",
			"Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
			"Wpa_gui",
			"veromix",
			"xtightvncviewer",
			"pavucontrol",
			"origin.exe",
			"file_progress",
			"confirm",
			"dialog",
			"download",
			"error",
			"notification",
			"splash",
			"toolbar",
		
		},
		type = {
			"utility",
			"notification",
			"toolbar",
			"splash",
			"dialog"
		},

		-- Note that the name property shown in xprop might be set slightly after creation of the client
		-- and the name shown there might not match defined rules here.
		name = {
			"Event Tester",  -- xev.
		},
		role = {
			"AlarmWindow",  -- Thunderbird's calendar.
			"ConfigManager",  -- Thunderbird's about:config.
			"pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
		}
	}, properties = { floating = true, placement = awful.placement.centered } },

	-- Add titlebars to normal clients and dialogs
	{ rule_any = {
		type = {
			"normal",
			"dialog"
		}
	}, properties = { titlebars_enabled = false } },

	{ rule_any = {
		class = {
			"freetube"
		}
	}, properties = { screen = 1, tag = "1" } },
	
	{ rule_any = {
		class = {
			"vscodium", "jetbrains-rider", "unityhub", "Unity"
		}
	}, properties = { screen = 1, tag = "2" } },
	
	{ rule_any = {
		class = {
			"discord",
			"element"
		}
	}, properties = { screen = 1, tag = "3" } },
}

return M
