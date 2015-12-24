local menubar   = require("menubar")
local awesome   = require("awesome")

local awful_menu= require("awful.menu")
local beautiful = require("beautiful")

local apps      = require("conf.apps")

-- Load Debian menu entries
require("debian.menu")

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", apps.terminal .. " -e man awesome" },
   { "edit config", apps.editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful_menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "Debian", debian.menu.Debian_menu.Debian },
                                    { "open terminal", apps.terminal }
                                  }
                        })

-- Menubar configuration
menubar.utils.terminal = apps.terminal -- Set the terminal for applications that require it -- }}}

return mymainmenu
