require("helpers")
require("wrapper")

load_stylesheet("./style.css")

new_window({
	title = "SMSH: Power",
	enable_vim_keys = true,
	enable_esc_as_exit = true,
	present = true,
	exit_on_close = true,
	root = {
		type = "container",
		orientation = "vertical",
		children = {
			{
				type = "button",
				text = "",
				tooltip = "Lock",
				action = function()
					os.execute("swaylock")
					os.exit(0)
				end,
			},
			{
				type = "button",
				text = "",
				tooltip = "Shutdown",
				action = function()
					confirm({
						message = "Shutdown?",
						present = true,
						exit_on_close = true,
						on_yes = function()
							run_unless_pacman("shutdown now")
							os.exit(0)
						end,
					})
				end,
			},
			{
				type = "button",
				text = "",
				tooltip = "Reboot",
				action = function()
					confirm({
						message = "Reboot?",
						present = true,
						exit_on_close = true,
						on_yes = function()
							run_unless_pacman("reboot")
							os.exit(0)
						end,
					})
				end,
			},
			{
				type = "button",
				text = "",
				tooltip = "Reboot into Windows",
				action = function()
					confirm({
						message = "Reboot into Windows?",
						present = true,
						exit_on_close = true,
						on_yes = function()
							run_unless_pacman("~/.config/scripts/reboot-into-windows.sh")
							os.exit(0)
						end,
					})
				end,
			},
			{
				type = "button",
				text = "󰗽",
				tooltip = "Logout",
				action = function()
					confirm({
						message = "Logout?",
						present = true,
						exit_on_close = true,
						on_yes = function()
							run_unless_pacman("hyprctl dispatch exit exit || swaymsg exit")
							os.exit(0)
						end,
					})
				end,
			},
		},
	},
})
