hl.monitor({
    output = "DP-3",
    mode = "2560x1440@180",
    position = "0x0",
    bitdepth = 10,
    sdrbrightness = 1.0,
    sdrsaturation = 1.2,
    vrr = 1,
    supports_wide_color = 1,
    supports_hdr = 1,
    sdr_min_luminance = 0,
    sdr_max_luminance = 200,
})

hl.monitor({
    output = "HDMI-A-1",
    mode = "1920x1080@60",
    position = "2560x0",
    bitdepth = 10,
    sdrbrightness = 1.0,
    sdrsaturation = 1.0,
    vrr = 1,
})

hl.config({
    general = {
        border_size = 8,
        gaps_in = 5,
        gaps_out = 10,
        col = {
            inactive_border = "rgba(BD93F9AA)",
            active_border = "rgba(8BE9FDFF)",
        },
        layout = "dwindle",
        no_focus_fallback = false,
        resize_on_border = false,
        allow_tearing = false,
        snap = {
            enabled = true,
        },
    },
    decoration = {
        rounding = 20,
        rounding_power = 2,
        active_opacity = 1,
        inactive_opacity = 0.9,
        fullscreen_opacity = 1,
        dim_inactive = false,
        screen_shader = "",
        border_part_of_window = true,
        blur = {
            enabled = false,
            size = 8,
            passes = 1,
            ignore_opacity = true,
            new_optimizations = true,
        },
        shadow = {
            enabled = true,
            range = 100,
            render_power = 4,
            sharp = false,
            scale = 1,
        },
    },
    animations = {
        enabled = true,
        workspace_wraparound = false,
    },
    input = {
        kb_model = "",
        kb_layout = "us",
        kb_variant = "",
        kb_options = "",
        kb_rules = "",
        kb_file = "",
        numlock_by_default = true,
        resolve_binds_by_sym = false,
        repeat_rate = 25,
        repeat_delay = 600,
        sensitivity = 0,
        accel_profile = "",
        force_no_accel = false,
        left_handed = false,
        scroll_points = "",
        scroll_method = "",
        scroll_button = 0,
        follow_mouse = 1,
        follow_mouse_threshold = 0,
        focus_on_close = 0,
        mouse_refocus = true,
        float_switch_override_focus = 1,
        special_fallthrough = false,
        off_window_axis_events = 1,
        emulate_discrete_scroll = 1,
        touchdevice = {
            transform = 0,
            output = "HDMI-A-1",
            enabled = true,
        },
    },
    misc = {
        disable_hyprland_logo = false,
        disable_splash_rendering = false,
        force_default_wallpaper = 0,
        vrr = 1,
        middle_click_paste = false,
    },
    xwayland = {
        enabled = true,
        use_nearest_neighbor = true,
    },
})

hl.curve("myBezier", {
    type = "bezier",
    points = {
        { 0.05, 0.9 },
        { 0.1,  1.05 },
    },
})

hl.animation({ leaf = "windows", enabled = true, speed = 7, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "default" })

local mainMod = "SUPER"

hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + T", hl.dsp.window.float({ action = "toggle" }))

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("alacritty"))
hl.bind(mainMod .. " + Y", hl.dsp.exec_cmd("rofi -show drun"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("thunar"))
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd("grimshot copy area"))

hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "d" }))

for workspace = 1, 10 do
    local key = workspace % 10 -- Workspace 10 is bound to the 0 key.
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = workspace }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = workspace }))
end

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.on("hyprland.start", function()
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("sleep 5 && killall .waybar-wrapped && sleep 2 && waybar")
    hl.exec_cmd("hyprpaper")
end)
