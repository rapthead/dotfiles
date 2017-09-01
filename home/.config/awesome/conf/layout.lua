local awful = require("awful")
awful.layout    = require("awful.layout")
awful.util      = require("awful.util")
awful.prompt    = require("awful.prompt")
awful.completion= require("awful.completion")
-- Widget and layout library
local wibox = require("wibox")
wibox.widget.imagebox = require("wibox.widget.imagebox")

local naughty = require("naughty")

local beautiful         = require("conf.beautiful")
local keybindings       = require("conf.keybindings")

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier
}
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {
   -- names = { "web", "term", "docs", "media", "files", "other" },
   names = { 
        "", -- f268
        "", -- f120
        "", -- f040
        "", -- f26c
        "", -- f07b
        "" --f12e
   },
   layout = {
       awful.layout.suit.max,
       awful.layout.suit.tile.left,
       awful.layout.suit.max,
       awful.layout.suit.floating,
       awful.layout.suit.fair.horizontal,
       awful.layout.suit.floating 
   }
}
for s = 1, screen.count() do
   -- Each screen has its own tag table.
   tags[s] = awful.tag(tags.names, s, tags.layout)
   -- awful.tag.seticon(cairo, tags[s][1])
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock("%H:%M")

-- Create a wibox for each screen and add it
mywibox = {}
mypromptwibox = {}
mypromptbox = {}
mylayoutbox = {}
mylayoutbox.buttons = keybindings.layoutboxbuttons

mytaglist = {}
mytaglist.buttons = keybindings.taglistbuttons

mytasklist = {}
mytasklist.buttons = keybindings.tasklistbuttons

-- local zipicon = wibox.widget.imagebox()
-- zipicon:set_image(awful.util.getdir("config") .. "/zip-box2.svg")

local wibox_vertical = true
for s = 1, screen.count() do
    local first_layout
    local last_layout
    local layout

    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()

    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(mylayoutbox.buttons)

    if (wibox_vertical) then
        first_layout = wibox.layout.fixed.vertical()
        last_layout = wibox.layout.fixed.vertical()
        layout = wibox.layout.align.vertical()

        -- Create a taglist widget
        mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons, false, false, wibox.layout.fixed.vertical())

        -- Create a tasklist widget
        mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons, false, false, wibox.layout.fixed.horizontal())
        mytasklist[s] = wibox.layout.rotate(mytasklist[s], "west")

        mypromptwibox[s] = awful.wibox({ position = "bottom", screen = s, ontop = true })
        mypromptwibox[s]:set_widget(mypromptbox[s])
        mypromptwibox[s].visible = false
    else
        first_layout = wibox.layout.fixed.horizontal()
        last_layout = wibox.layout.fixed.horizontal()
        layout = wibox.layout.align.horizontal()

        -- Create a taglist widget
        mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

        -- Create a tasklist widget
        mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

        first_layout:add(mypromptbox[s])
    end

    -- Widgets that are aligned to the left
    first_layout:add(mylauncher)
    first_layout:add(mytaglist[s])

    -- Widgets that are aligned to the right
    if s == 1 then last_layout:add(wibox.widget.systray()) end
    -- last_layout:add(zipicon)
    last_layout:add(mytextclock)
    last_layout:add(mylayoutbox[s])

    -- Now bring it all together (with the tasklist in the middle)
    if (wibox_vertical) then
        layout:set_top(first_layout)
        layout:set_middle(mytasklist[s])
        layout:set_bottom(last_layout)
        mywibox[s] = awful.wibox({ position = "left", screen = s, width = 35 })
    else
        layout:set_left(first_layout)
        layout:set_middle(mytasklist[s])
        layout:set_right(last_layout)
        mywibox[s] = awful.wibox({ position = "top", screen = s })
    end

    -- Create the wibox
    mywibox[s]:set_widget(layout)
end

function runprompt() 
    local current_screen = mouse.screen
    if wibox_vertical then
        mypromptwibox[mouse.screen].visible = true
    end
    -- function prompt.run(args, textbox, exe_callback, completion_callback, history_path, history_max, done_callback, changed_callback, keypressed_callback)
    awful.prompt.run(
        { prompt = "Run: " },                   --args
        mypromptbox[mouse.screen].widget,       --textbox
        function (...)                          --exe_callback
            local result = awful.util.spawn(...)
            if type(result) == "string" then
                -- mypromptbox[current_screen].widget:set_text(result)
                naughty.notify({ preset = naughty.config.presets.normal,
                                -- title = "Oops, there were errors during startup!",
                                text = result })
            end
        end,
        awful.completion.shell,                       --completion_callback
        awful.util.getdir("cache") .. "/history", --history_path
        nil,                                    -- history_max
        function()                              -- done_callback
            if wibox_vertical then
               mypromptwibox[mouse.screen].visible = false
            end
        end
    )
end

function luaprompt()
    local current_screen = mouse.screen
    if wibox_vertical then
        mypromptwibox[current_screen].visible = true
    end
    -- function prompt.run(args, textbox, exe_callback, completion_callback, history_path, history_max, done_callback, changed_callback, keypressed_callback)
    awful.prompt.run(
        { prompt = "Run Lua code: " },          --args
        mypromptbox[current_screen].widget,     --textbox
        awful.util.eval,                        --exe_callback
        nil,                                    --completion_callback
        awful.util.getdir("cache") .. "/history_eval", --history_path
        nil,                                    -- history_max
        function()                              -- done_callback
            if wibox_vertical then
                mypromptwibox[current_screen].visible = false
            end
        end
        -- changed_callback
        -- keypressed_callback
    )
end

function layoutnext() awful.layout.inc(layouts, 1) end
function layoutprev() awful.layout.inc(layouts,-1) end
-- }}}

return {
    tags = tags
}
