local gears = require("gears")
local awful = require("awful")
-- Theme handling library
local beautiful = require("beautiful")

-- Themes define colours, icons, font and wallpapers.
beautiful.init(awful.util.getdir("config") .. "/theme/theme.lua")

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
-- }}}

return beautiful
