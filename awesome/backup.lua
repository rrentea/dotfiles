
-- {{{ Wibar
-- Create a textclock widget
local mytextclock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
    awful.button({}, 1, function(t)
        t:view_only()
    end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({}, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({}, 4, function(t)
        awful.tag.viewnext(t.screen)
    end),
    awful.button({}, 5, function(t)
        awful.tag.viewprev(t.screen)
    end)
)

local tasklist_buttons = gears.table.join(
    awful.button({}, 1, function(c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal("request::activate", "tasklist", { raise = true })
        end
    end),
    awful.button({}, 3, function()
        awful.menu.client_list({ theme = { width = 250 } })
    end),
    awful.button({}, 4, function()
        awful.client.focus.byidx(1)
    end),
    awful.button({}, 5, function()
        awful.client.focus.byidx(-1)
    end)
)

local markup = lain.util.markup

local cpu = lain.widget.cpu({
    timeout = 1,
    settings = function()
        widget:set_markup(markup.fontfg(beautiful.font, beautiful.yellow, " " .. cpu_now.usage .. "%"))
    end,
})

cpu.widget:buttons(awful.util.table.join(
    awful.button({}, 1, function()
        awful.spawn(terminal .. ' btop')
    end)
))

local mem = lain.widget.mem({
    timeout = 1,
    settings = function()
        widget:set_markup(markup.fontfg(beautiful.font, beautiful.blue, " " .. mem_now.perc .. "%"))
    end,
})

mem.widget:buttons(awful.util.table.join(
    awful.button({}, 1, function()
        awful.spawn(terminal .. ' btop')
    end)
))

local systray = wibox.widget.systray()

local vol = lain.widget.alsa({
    timeout = 1,
    settings = function()
        if volume_now.level == 0 or volume_now.muted == 'true' then
            volume_now.level = "Muted"
            widget:set_markup(markup.fontfg(beautiful.font, beautiful.grey, "婢 " .. volume_now.level))
        else
            widget:set_markup(markup.fontfg(beautiful.font, beautiful.pink, "奔 " .. volume_now.level .. "% "))
        end
    end,
})

vol.widget:buttons(awful.util.table.join(
    awful.button({}, 1, function() -- left click
        awful.spawn("pamixer -t")
        vol.update()
    end),
    awful.button({}, 3, function() -- right click
        awful.spawn("pavucontrol")
    end),
    awful.button({}, 4, function() -- scroll up
        awful.spawn("pamixer -i 3")
        vol.update()
    end),
    awful.button({}, 5, function() -- scroll down
        awful.spawn("pamixer -d 3")
        vol.update()
    end)
))

brightness.widget:buttons(awful.util.table.join(
    awful.button({}, 1, function() -- left click
        awful.spawn("brightness-controller")
        vol.update()
    end),
    awful.button({}, 4, function() -- scroll up
        brightness:up()
    end),
    awful.button({}, 5, function() -- scroll down
        brightness:down()
    end)
))

-- -- Create the battery widget:
-- local my_battery_widget = battery_widget {
--     screen = screen,
--     use_display_device = true,
--     widget_template = wibox.widget.textbox
-- }
--
-- my_battery_widget:connect_signal('upower::update', function (widget, device)
--     widget.text = string.format('%3d', device.percentage) .. '%'
-- end)
local batteryarc_widget = require("themes.default.batteryarc-widget.batteryarc")


local mpris = require("themes.default.mpris")
local mpd = require("themes.default.mpdarc")
local spacer = wibox.widget.textbox(" ")

local tag1 = " 1 "
local tag2 = "  "
local tag3 = " 3 "
local tag4 = "  "
local tag5 = " 5 "
local tag6 = " 6 "
local tag7 = " 7 "
local tag8 = " 8 "
local tag9 = " 9 "

-- local tag1 = "  "
-- local tag2 = "  "
-- local tag3 = "  "
-- local tag4 = "  "
-- local tag5 = "  "
-- local tag6 = "  "
-- local tag7 = "  "
-- local tag8 = " ﴬ "
-- local tag9 = "  "
awful.screen.connect_for_each_screen(function(s)
    -- Each screen has its own tag table.
    awful.tag.add(tag1, {
        layout = awful.layout.layouts[1],
        master_fill_policy = "master_width_factor",
        screen = s,
        selected = true,
    })

    awful.tag.add(tag2, {
        layout = awful.layout.layouts[1],
        master_fill_policy = "master_width_factor",
        screen = s,
    })

    awful.tag.add(tag3, {
        layout = awful.layout.layouts[1],
        master_fill_policy = "master_width_factor",
        screen = s,
    })

    awful.tag.add(tag4, {
        layout = awful.layout.layouts[1],
        master_fill_policy = "master_width_factor",
        screen = s,
    })

    awful.tag.add(tag5, {
        layout = awful.layout.layouts[1],
        master_fill_policy = "master_width_factor",
        screen = s,
    })

    if s == screen[1] then
        awful.tag.add(tag6, {
            layout = awful.layout.layouts[5],
            master_fill_policy = "master_width_factor",
            screen = s,
        })
    else
        awful.tag.add(tag6, {
            layout = awful.layout.layouts[4],
            master_fill_policy = "master_width_factor",
            screen = s,
        })
    end

    awful.tag.add(tag7, {
        layout = awful.layout.layouts[1],
        master_fill_policy = "master_width_factor",
        screen = s,
    })

    awful.tag.add(tag8, {
        layout = awful.layout.layouts[1],
        master_fill_policy = "master_width_factor",
        screen = s,
    })

    awful.tag.add(tag9, {
        layout = awful.layout.layouts[1],
        master_fill_policy = "master_width_factor",
        screen = s,
    })

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
        awful.button({}, 1, function()
            awful.layout.inc(1)
        end),
        awful.button({}, 3, function()
            awful.layout.inc(-1)
        end),
        awful.button({}, 4, function()
            awful.layout.inc(1)
        end),
        awful.button({}, 5, function()
            awful.layout.inc(-1)
        end)
    ))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist({
        screen = s,
        filter = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
    })

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist({
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        style    = {
            shape_border_width = 1,
            shape_border_color = '#777777',
            shape  = gears.shape.rounded_bar,
        },
    })


    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    if s == screen[1] then
        -- Add widgets to the wibox
        s.mywibox:setup({
            layout = wibox.layout.align.horizontal,
            { -- Left widgets
                layout = wibox.layout.fixed.horizontal,
                mylauncher,
                s.mytaglist,
            },
            s.mytasklist, -- Middle widget
            { -- Right widgets
                layout = wibox.layout.fixed.horizontal,
                spacer,
                cpu,
                spacer,
                mem,
                spacer,
                vol,
                brightness.widget,
                spacer,
                batteryarc_widget({
                    -- font = beautiful.font,
                    main_color = beautiful.green,
                    show_current_level = true,
                    arc_thickness = 1,
                }),
                mytextclock,
                systray,
                spacer,
                s.mylayoutbox,
            },
        })
    else
        -- Add widgets to the wibox
        s.mywibox:setup({
            layout = wibox.layout.align.horizontal,
            { -- Left widgets
                layout = wibox.layout.fixed.horizontal,
                mylauncher,
                s.mytaglist,
            },
            s.mytasklist, -- Middle widget
            { -- Right widgets
                layout = wibox.layout.fixed.horizontal,
                -- mpd,
                spacer,
                cpu,
                spacer,
                mem,
                spacer,
                vol,
                my_battery_widget,
                mytextclock,
                spacer,
                s.mylayoutbox,
            },
        })
    end
end)

-- }}}
