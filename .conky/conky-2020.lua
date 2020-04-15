require 'cairo'
require 'imlib2'

-- Converts degrees to radians
function deg_to_rad(deg)
    local rad = (deg - 90) * (math.pi / 180)
    return rad
end

-- Converts celsius to fahrenheit
function degc_to_degf(degc)
    return math.floor(1.8 * degc + 32)
end

-- Returns rgb(x, y, z) in a form that Cairo can use.
function rgb(r, g, b)
    local red = r / 255
    local green = g / 255
    local blue = b / 255

    return { red, green, blue }
end

-- Draws a line. Points are given as a 2d array [[x, y], [x2, y2] ...]
function draw_line(points, rgb, alpha, width)
    cairo_set_line_width(cr, width)
    cairo_set_line_cap(cr, CAIRO_LINE_CAP_SQUARE)
    cairo_set_source_rgba(cr, rgb[1], rgb[2], rgb[3], alpha)
    cairo_move_to(cr, points[1][1], points[1][2])
    for i = 2, #points do
        cairo_line_to(cr, points[i][1], points[i][2])
    end
    cairo_stroke(cr)
end

-- Draws a polygon. Points are given as a 2d array [[x, y], [x2, y2] ...]
function draw_poly(points, fill_rgb, fill_alpha, stroke_rgb, stroke_alpha, stroke_width)
    cairo_move_to(cr, points[1][1], points[1][2])
    for i = 2, #points do
        cairo_line_to(cr, points[i][1], points[i][2])
    end
    cairo_close_path(cr)
    cairo_set_source_rgba(cr, fill_rgb[1], fill_rgb[2], fill_rgb[3], fill_alpha)
    cairo_fill_preserve(cr)
    cairo_set_source_rgba(cr, stroke_rgb[1], stroke_rgb[2], stroke_rgb[3], stroke_alpha)
    cairo_set_line_width(cr, stroke_width)
    cairo_stroke(cr)
end

-- Draws text at {x, y}. Align can be "LEFT," "CENTER," or "RIGHT"
function draw_text(point, text, font, font_size, align, rgb, alpha)
    cairo_select_font_face(cr, font, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL)
    cairo_set_font_size(cr, font_size)
    cairo_set_source_rgba(cr, rgb[1], rgb[2], rgb[3], alpha)
    if align == "CENTER" then
        local extents = cairo_text_extents_t:create()
        tolua.takeownership(extents)
        cairo_text_extents(cr, text, extents)
        point[1] = point[1] - extents.width / 2 + extents.x_bearing
    end
    if align == "RIGHT" then
        local extents = cairo_text_extents_t:create()
        tolua.takeownership(extents)
        cairo_text_extents(cr, text, extents)
        point[1] = point[1] - extents.width - extents.x_bearing
    end
    cairo_move_to(cr, point[1], point[2])
    cairo_show_text(cr, text)
    cairo_stroke(cr)
end

-- Draws multi-line text anchored top-left at point {x, y}
function multiline_text(point, text, font, font_size, align, rgb, alpha)
    local index = 0
    for i in string.gmatch(text, "[^\r\n]+") do
        draw_text({ point[1], point[2] + ((font_size + 2) * index) }, i, font, font_size, align, rgb, alpha)
        index = index + 1
    end
end

-- Renders an image from file at {x, y}.
function draw_image(point, file)
    local show = imlib_load_image(file)
    if show == nil then return end
    imlib_context_set_image(show)
    local width = imlib_image_get_width()
    local height = imlib_image_get_height()
    imlib_context_set_image(show)
    imlib_render_image_on_drawable(point[1], point[2])
    imlib_free_image()
end

-- Draws a bar graph showing value as a percentage of value_max anchord top-left on point {x, y}.
-- Type can be "HORIZONTAL" or "VERTICAL"
function draw_bar_graph(point, type, value, value_max, bar_width, bar_height, label, font, font_size, rgb, alpha, rgb_background, alpha_background, rgb_font, alpha_font)
    if tonumber(value) == nil then
        return false;
    end
    -- Draw background
    cairo_set_source_rgba(cr, rgb_background[1], rgb_background[2], rgb_background[3], alpha_background)
    cairo_rectangle(cr, point[1], point[2], bar_width, bar_height)
    cairo_fill(cr)

    -- Draw bar
    local meter_size = 0
    cairo_select_font_face(cr, font, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_BOLD)
    cairo_set_font_size(cr, font_size)
    cairo_set_source_rgba(cr, rgb[1], rgb[2], rgb[3], alpha + ((0.4 * alpha) * (value / value_max)) - (0.2 * alpha))
    if type == "HORIZONTAL" then
        meter_size = bar_width * (value / value_max)
        cairo_rectangle(cr, point[1], point[2], meter_size, bar_height)
        cairo_fill(cr)
        -- Label
        if label then
            local extents = cairo_text_extents_t:create()
            tolua.takeownership(extents)
            cairo_text_extents(cr, label, extents)
            draw_text({ point[1], point[2] - extents.height }, label, font, font_size, "LEFT", rgb_font, alpha_font)
            local val_txt = value .. "%"
            draw_text({ point[1] + bar_width + 4, point[2] + (bar_height / 2) + (extents.height / 2) }, val_txt, font, font_size, "LEFT", rgb_font, alpha_font)
        end
    end
    if type == "VERTICAL" then
        meter_size = bar_height * (value / value_max)
        cairo_rectangle(cr, point[1], point[2] + bar_height, bar_width, -1 * meter_size)
        cairo_fill(cr)
        -- Label
        if label then
            local extents = cairo_text_extents_t:create()
            tolua.takeownership(extents)
            cairo_text_extents(cr, label, extents)
            draw_text({ point[1] + (bar_width / 2), point[2] + bar_height + extents.height + 8 }, label, font, font_size, "CENTER", rgb_font, alpha_font)
            local val_txt = value .. "%"
            draw_text({ point[1] + (bar_width / 2), point[2] - extents.height }, val_txt, font, font_size, "CENTER", rgb_font, alpha_font)
        end
    end
end

-- Draws a circular graph showing value as a percentage of value_max centered on point {x, y}.
-- Type can be "CIRCLE", "GAUGE", "TOP", "TOP_RIGHT", "RIGHT", ... for quarter and half circles.
function draw_circle_graph(point, type, value, value_max, radius, bar_width, label, font, font_size, rgb, alpha, rgb_background, alpha_background, rgb_font, alpha_font)
    if tonumber(value) == nil then
        return false;
    end
    local arc_tbl = {
        ["CIRCLE"] = { 1.5 * math.pi, 3.5 * math.pi, 0, 0 },
        ["GAUGE"] = { 0.75 * math.pi, 2.25 * math.pi, 0, 0.15 },
        ["LEFT"] = { 0.5 * math.pi, 1.5 * math.pi, -0.4, 0 },
        ["TOP"] = { math.pi, 2 * math.pi, 0, -0.4 },
        ["RIGHT"] = { 1.5 * math.pi, 2.5 * math.pi, 0.4, 0 },
        ["BOTTOM"] = { 0, math.pi, 0, 0.4 },
        ["TOP_LEFT"] = { math.pi, 1.5 * math.pi, -0.4, -0.4 },
        ["TOP_RIGHT"] = { 1.5 * math.pi, 2 * math.pi, 0.4, -0.4 },
        ["BOTTOM_RIGHT"] = { 2 * math.pi, 2.5 * math.pi, 0.4, 0.4 },
        ["BOTTOM_LEFT"] = { 0.5 * math.pi, math.pi, -0.4, 0.4 }
    }
    local arc_start = arc_tbl[type][1]
    local arc_end = arc_tbl[type][2]
    -- Draw background
    cairo_set_line_width(cr, bar_width)
    cairo_set_source_rgba(cr, rgb_background[1], rgb_background[2], rgb_background[3], alpha_background)
    cairo_arc(cr, point[1], point[2], radius, arc_start, arc_end)
    cairo_stroke(cr)

    local angle_start = arc_start
    local angle_end = arc_start + (tonumber(value) * (math.abs(arc_end - arc_start) / tonumber(value_max)))

    -- Draw bar
    cairo_set_source_rgba(cr, rgb[1], rgb[2], rgb[3], alpha + ((0.4 * alpha) * (tonumber(value) / tonumber(value_max))) - (0.2 * alpha))
    cairo_arc(cr, point[1], point[2], radius, angle_start, angle_end)
    cairo_stroke(cr)

    -- Label
    if label then
        local extents = cairo_text_extents_t:create()
        tolua.takeownership(extents)
        cairo_select_font_face(cr, font, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_BOLD)
        cairo_set_font_size(cr, font_size)

        local text_mod_x = arc_tbl[type][3] * radius
        local text_mod_y = arc_tbl[type][4] * radius

        cairo_text_extents(cr, label, extents)
        local label_x = point[1] + text_mod_x
        local label_y = point[2] - (extents.height / 2 + extents.y_bearing) + text_mod_y - 9
        draw_text({ label_x, label_y }, label, font, font_size, "CENTER", rgb_font, alpha_font)

        local val_txt = value .. "%"
        cairo_text_extents(cr, val_txt, extents)
        local val_x = point[1] + text_mod_x
        local val_y = point[2] - (extents.height / 2 + extents.y_bearing) + text_mod_y + 9

        draw_text({ val_x, val_y }, val_txt, font, font_size, "CENTER", rgb_font, alpha_font)
    end
end

function conky_main()
    if conky_window == nil then
        return
    end

    local cs = cairo_xlib_surface_create(conky_window.display,
        conky_window.drawable,
        conky_window.visual,
        conky_window.width,
        conky_window.height)
    cr = cairo_create(cs)

    local ticks = tonumber(conky_parse("${updates}"))

    -- Font Settings
    local main_font = "DejaVuSansMono"
    local accent_font = "Neon"
    local main_font_size = 16
    local accent_font_size = 24

    -- Line Width
    local primary_line_width = 3
    local secondary_line_width = 2

    -- RGBA Settings
    local poly_bg_rgb = rgb(33, 33, 33)
    local poly_bg_alpha = 0.6
    -- local primary_rgb = rgb(100, 241, 121) -- linecolor # #64f179
    local primary_rgb = rgb(117, 239, 255) --linecolor 1
    local primary_alpha = 0.85
    local secondary_rgb = rgb(255, 255, 255)
    local debug_rgb = rgb(255, 0, 0)
    local secondary_alpha = 0.55
    local graph_bg_rgb = rgb(0, 0, 0)
    local graph_bg_alpha = 0.9
    local neon_red = rgb(208, 64, 161)
    local neon_yellow = rgb(255, 255, 132)


    -- Angle slope ratio = 118/130 = .907692307692
    --[[ local poly_right = {
         {1940, -20},
         {1420, -20},
         {1420, 0},
         {1550, 118},
         {1680, 236},
         {1680, 418},
         {1720, 454},
         {1720, 743},
         {1547, 900},
         {900, 900},
         {792, 1080},
         {792, 1100},
         {1940, 1100}
     } --]]
    --[[local poly_right = {
        {0, 0},
        {0 , 32},
        {1940, 32},
        {1940,0}
    }
]] --

    local poly_bottom = {
        { 0, 335 },
        { 70, 335 },
        { 100, 380 },
        { 100, 760 },
        { 150, 760 },
        { 150 + 30, 800 },
        { 150 + 30, 980 },
        { 150, 1020 }, -- left down cpu corner
        { 150, 1077 }, -- left down corner
        { 830, 1077 }, -- left up
        { 870, 1080 - 45 }, --left down (left down -50)
        { 1100, 1080 - 45 }, -- right up
        { 1150, 1077 }, -- right down (right up -50)
        { 1930, 1077 },
        { 1930, 1090 },
        { 0, 1090 }
    }

    local poly_right = {
        { 1930, 1070 },
        { 1920 - 45, 1080 - 45 },
        { 1750, 1080 - 45 },
        { 1750, 800 }
    }
    -- Bottom Dock Bar
    draw_poly(poly_bottom, poly_bg_rgb, poly_bg_alpha, primary_rgb, primary_alpha, primary_line_width)
    draw_image({ 900, 1040 }, "/home/alex/dotfile/.conky/images/firefox.png")
    draw_image({ 970, 1040 }, "/home/alex/dotfile/.conky/images/file-manager.png")
    draw_image({ 1040, 1040 }, "/home/alex/dotfile/.conky/images/terminal.png")

    draw_text({ 59, 860 }, "CPU", accent_font, accent_font_size, "LEFT", primary_rgb, primary_alpha)
    draw_circle_graph({ 50, 900 }, "GAUGE", conky_parse("${cpu cpu0}"), 100, 26, 7, "1", main_font, main_font_size, primary_rgb, primary_alpha, graph_bg_rgb, graph_bg_alpha, secondary_rgb, primary_alpha)
    draw_circle_graph({ 50 + 80, 900 }, "GAUGE", conky_parse("${cpu cpu1}"), 100, 26, 7, "2", main_font, main_font_size, neon_yellow, primary_alpha, graph_bg_rgb, graph_bg_alpha, secondary_rgb, primary_alpha)
    draw_circle_graph({ 50, 980 }, "GAUGE", conky_parse("${cpu cpu2}"), 100, 26, 7, "3", main_font, main_font_size, neon_yellow, primary_alpha, graph_bg_rgb, graph_bg_alpha, secondary_rgb, primary_alpha)
    draw_circle_graph({ 50 + 80, 980 }, "GAUGE", conky_parse("${cpu cpu3}"), 100, 26, 7, "4", main_font, main_font_size, primary_rgb, primary_alpha, graph_bg_rgb, graph_bg_alpha, secondary_rgb, primary_alpha)

    -- clock and date
    draw_text({ 135, 1060 }, conky_parse("${time %H:%M:%S}"), main_font, 25, "RIGHT", primary_rgb, primary_alpha) -- time -- NEON COLOR

    -- RAM
    draw_text({ 20, 760 }, "RAM", accent_font, accent_font_size, "LEFT", primary_rgb, primary_alpha)
    draw_bar_graph({ 20, 810 }, "HORIZONTAL", conky_parse("${memperc}"), 100, 110, 10, string.sub(conky_parse("${mem}"), 0, 2) .. "GiB" .. ' / ' .. string.sub(conky_parse("${memmax}"), 0, 2) .. "GiB", main_font, main_font_size, neon_yellow, primary_alpha, graph_bg_rgb, graph_bg_alpha, neon_yellow, primary_alpha)

    -- TetrisIQ
    draw_image({ -10, 350 }, "/home/alex/dotfile/.conky/tetrisiq-neon-90.png")



    --[[
        -- right stats Bar
        draw_poly(poly_right, poly_bg_rgb, poly_bg_alpha, primary_rgb, primary_alpha, primary_line_width)

        -- CPU
        draw_circle_graph({1695 + 110, 900}, "GAUGE", conky_parse("${cpu cpu0}"), 100, 26, 7, "1", main_font, main_font_size, primary_rgb, primary_alpha, graph_bg_rgb, graph_bg_alpha, secondary_rgb, primary_alpha)
        draw_circle_graph({1758 + 110, 900}, "GAUGE", conky_parse("${cpu cpu1}"), 100, 26, 7, "2", main_font, main_font_size, primary_rgb, primary_alpha, graph_bg_rgb, graph_bg_alpha, secondary_rgb, primary_alpha)
        draw_circle_graph({1695 + 110, 980}, "GAUGE", conky_parse("${cpu cpu2}"), 100, 26, 7, "3", main_font, main_font_size, primary_rgb, primary_alpha, graph_bg_rgb, graph_bg_alpha, secondary_rgb, primary_alpha)
        draw_circle_graph({1758 + 110, 980}, "GAUGE", conky_parse("${cpu cpu3}"), 100, 26, 7, "4", main_font, main_font_size, primary_rgb, primary_alpha, graph_bg_rgb, graph_bg_alpha, secondary_rgb, primary_alpha)
    --]]
    -- Cleanup
    cairo_destroy(cr)
    cairo_surface_destroy(cs)
    cr = nil
end
