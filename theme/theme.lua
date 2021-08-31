---------------------------
-- Default awesome theme --
---------------------------

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local theme = {}

theme.font          = "Cantarell Bold 10"

theme.bg_normal     = "#000000"
theme.bg_focus      = "#ff5555"
theme.bg_urgent     = "#ff5555"
theme.bg_minimize   = "#282a36"
theme.bg_systray    = theme.bg_normal
theme.systray_icon_spacing = 8

theme.fg_normal     = "#f8f8f2"
theme.taglist_fg_empty = "#282a36"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#f8f8f2"
theme.fg_minimize   = "#f8f8f2"

theme.tasklist_bg_normal = theme.bg_normal
theme.tasklist_bg_focus = theme.bg_normal
theme.tasklist_bg_urgent = theme.bg_normal
theme.tasklist_disable_icon = true
theme.tasklist_plain_task_name = false

theme.gap_single_client = true
theme.useless_gap   = dpi(4)
theme.border_width  = 2
theme.border_normal = "#282a36"
theme.border_focus  = "#bd93f9"
theme.border_marked = "#ff5555"

theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

theme.wallpaper = "~/.config/wallpaper/background.png"
theme.icon_theme = nil

return theme
