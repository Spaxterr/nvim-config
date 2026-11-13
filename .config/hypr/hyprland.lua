-- Catppuccin Frappé, glass look. Hyprland 0.57+ reads only this Lua file.
--
-- New machine (Arch/CachyOS):
--   sudo pacman -S --needed hyprland hyprpaper hyprlock hypridle hyprpolkitagent \
--     xdg-desktop-portal-hyprland waybar rofi swaync kitty dolphin jq pavucontrol \
--     network-manager-applet blueman brightnessctl playerctl wl-clipboard grim slurp dex satty \
--     ttf-jetbrains-mono-nerd qt5-wayland qt6-wayland plasma-integration
--   Cursor theme (AUR): catppuccin-cursors-frappe
--   Dolphin/Qt colours come from the Plasma theme (kdeglobals + Kvantum), which is not in this repo.

local mod = "SUPER"
local terminal = "kitty"
local menu = "rofi -show drun"
local files = "dolphin"

-- MONITORS: whatever is plugged in gets its native mode, placed left -> right automatically
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })
-- Layouts saved from the GUI (scripts/monitors-gui.sh) override the auto rule, per monitor model
local saved = os.getenv("HOME") .. "/.config/hypr/monitors.lua"
if io.open(saved) then dofile(saved) end

hl.env("XCURSOR_THEME", "catppuccin-frappe-mauve-cursors")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
-- Qt apps use your Plasma theme (colours, Kvantum style, icons); Qt only loads it by default in a KDE session
hl.env("QT_QPA_PLATFORMTHEME", "kde")

hl.on("hyprland.start", function()
	-- Same autostart as KDE: ~/.config/autostart + /etc/xdg/autostart (.desktop files; Hidden=true ones are skipped)
	hl.exec_cmd("dex --autostart --environment Hyprland")
	hl.exec_cmd("waybar")
	hl.exec_cmd("swaync")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("nm-applet --indicator")
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme 'catppuccin-frappe-mauve-cursors'")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")
end)

hl.config({
	input = {
		kb_layout = "se",
		follow_mouse = 1,
		repeat_delay = 300,
		repeat_rate = 40,
		touchpad = { natural_scroll = true },
	},
	-- Hybrid Intel + NVIDIA: hardware cursors leave a ghost cursor on the secondary GPU's output
	cursor = { no_hardware_cursors = true },
	general = {
		gaps_in = 6,
		gaps_out = 12,
		border_size = 2,
		col = {
			active_border = { colors = { "rgba(ca9ee6ff)", "rgba(8caaeeff)" }, angle = 45 },
			inactive_border = "rgba(51576d80)",
		},
		layout = "dwindle",
		resize_on_border = true,
	},
	decoration = {
		rounding = 14,
		active_opacity = 0.92,
		inactive_opacity = 0.85,
		fullscreen_opacity = 1.0,
		blur = {
			enabled = true,
			size = 8,
			passes = 3,
			new_optimizations = true,
			noise = 0.02,
			brightness = 0.9,
			vibrancy = 0.2,
			popups = true,
			-- Floating windows blur only the wallpaper, not the tiles behind them
			xray = true,
		},
		shadow = {
			enabled = true,
			range = 24,
			render_power = 4,
			offset = { 0, 4 },
			color = "rgba(23263699)",
		},
	},
	animations = { enabled = true },
	dwindle = { preserve_split = true },
	-- Tabbed groups: several windows share one tile, switch with Super+Tab or by clicking a tab
	group = {
		col = {
			border_active = { colors = { "rgba(ca9ee6ff)", "rgba(8caaeeff)" }, angle = 45 },
			border_inactive = "rgba(51576d80)",
		},
		groupbar = {
			font_family = "Inter",
			font_size = 11,
			height = 20,
			gradients = true,
			rounding = 8,
			indicator_height = 0,
			blur = true,
			col = { active = "rgba(ca9ee6cc)", inactive = "rgba(414559b3)" },
			text_color = "rgb(232634)",
			text_color_inactive = "rgb(c6d0f5)",
		},
	},
	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		force_default_wallpaper = 0,
		background_color = "rgb(232634)",
	},
})

hl.curve("smooth", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.curve("ease", { type = "bezier", points = { { 0.25, 1 }, { 0.5, 1 } } })
hl.animation({ leaf = "windows", enabled = true, speed = 5, bezier = "smooth", style = "popin 85%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 4, bezier = "ease", style = "popin 85%" })
hl.animation({ leaf = "fade", enabled = true, speed = 5, bezier = "ease" })
hl.animation({ leaf = "border", enabled = true, speed = 8, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "ease", style = "slide" })
hl.animation({ leaf = "layers", enabled = true, speed = 4, bezier = "ease", style = "fade" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 5, bezier = "ease", style = "slidevert" })

-- Glass blur behind the bar, launcher and notifications
for _, ns in ipairs({ "waybar", "rofi", "swaync-control-center", "swaync-notification-window" }) do
	hl.layer_rule({ name = "blur-" .. ns, match = { namespace = "^" .. ns .. "$" }, blur = true, ignore_alpha = 0 })
end
hl.layer_rule({ name = "rofi-popin", match = { namespace = "^rofi$" }, animation = "popin 90%" })

-- Pin the everyday workspaces: 1 middle, 2 left, 3 right (Waybar shows them even when empty)
hl.workspace_rule({ workspace = "1", monitor = "HDMI-A-1", default = true, persistent = true })
hl.workspace_rule({ workspace = "2", monitor = "DP-1", default = true, persistent = true })
hl.workspace_rule({ workspace = "3", monitor = "DP-2", default = true, persistent = true })

hl.window_rule({ name = "suppress-maximize", match = { class = ".*" }, suppress_event = "maximize" })
-- kitty does its own background transparency (crisp text); keep video fully opaque
hl.window_rule({ name = "opaque", match = { class = "^(kitty|mpv|vlc)$" }, opacity = "1.0 override 1.0 override" })
hl.window_rule({
	name = "float-utils",
	match = { class = "^(pavucontrol|org.pulseaudio.pavucontrol|nm-connection-editor|blueman-manager)$" },
	float = true,
	size = "720 540",
})
hl.window_rule({ name = "float-polkit", match = { class = "^(.*polkit.*)$" }, float = true, center = true })

hl.bind(mod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mod .. " + W", hl.dsp.exec_cmd("rofi -show window"))
hl.bind(mod .. " + E", hl.dsp.exec_cmd(files))
hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mod .. " + J", hl.dsp.layout("togglesplit"))
-- Minimize = park the window on a hidden special workspace; Super+U (or the bar counter) restores it
hl.bind(mod .. " + M", hl.dsp.window.move({ workspace = "special:minimized", follow = false }))
hl.bind(mod .. " + U", hl.dsp.exec_cmd("~/.config/hypr/scripts/restore.sh"))
hl.bind(mod .. " + G", hl.dsp.group.toggle())
hl.bind(mod .. " + Tab", hl.dsp.group.next())
hl.bind(mod .. " + SHIFT + Tab", hl.dsp.group.prev())
hl.bind(mod .. " + L", hl.dsp.exec_cmd("loginctl lock-session"))
hl.bind(mod .. " + N", hl.dsp.exec_cmd("swaync-client -t -sw"))
local shot = "~/.config/hypr/scripts/screenshot.sh"
hl.bind("Print", hl.dsp.exec_cmd(shot .. " region"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd(shot .. " window"))
hl.bind(mod .. " + Print", hl.dsp.exec_cmd(shot .. " screen"))

hl.bind(mod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + down", hl.dsp.focus({ direction = "down" }))
hl.bind(mod .. " + SHIFT + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mod .. " + SHIFT + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mod .. " + SHIFT + down", hl.dsp.window.move({ direction = "down" }))

for i = 1, 10 do
	local key = i % 10
	hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

local media = { locked = true, repeating = true }
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), media)
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), media)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
local mic = "~/.config/hypr/scripts/mic-toggle.sh"
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(mic), { locked = true })
hl.bind(mod .. " + SHIFT + A", hl.dsp.exec_cmd(mic))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
