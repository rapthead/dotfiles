local awful             = require("awful")
awful.rules             = require("awful.rules")

local bindings          = require("conf.keybindings")
local beautiful         = require("conf.beautiful")
local layout            = require("conf.layout")

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = bindings.clientkeys,
                     buttons = bindings.clientbuttons } },
    { rule = { role = "browser" },
      properties = { tag = layout.tags[1][1] } },
    { rule = { role = "pop-up" },
      properties = { floating = true },
      callback = function (c)
        awful.placement.centered(c,nil)
      end
    },
    { rule_any = { class = { "MPlayer", "mpv", "Steam", "feh", "gimp" } },
      properties = { floating = true, tag = layout.tags[1][4], switchtotag = layout.tags[1][4], focus = true } },
}
-- }}}
