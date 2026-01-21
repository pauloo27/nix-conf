require("helpers")
require("wrapper")

load_stylesheet("./style.css")

local hostname = io.popen("hostname"):read("*l")
local has_windows = hostname == "melinda"

local options = {
	{
		type = "button",
		text = "",
		tooltip = "Lock",
		classes = { "main_button" },
		action = function()
			os.execute("hyprlock &")
			os.exit(0)
		end,
	},
	{
		type = "button",
		text = "",
		tooltip = "Shutdown",
		classes = { "main_button" },
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
		classes = { "main_button" },
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
		text = "󰗽",
		tooltip = "Logout",
		classes = { "main_button" },
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
}

if has_windows then
	table.insert(options, {
		type = "button",
		text = "",
		tooltip = "Reboot into Windows",
		classes = { "main_button" },
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
	})
end

new_window({
	title = "SMSH: Power",
	enable_vim_keys = true,
	enable_esc_as_exit = true,
	present = true,
	exit_on_close = true,
	root = {
		type = "container",
		orientation = "vertical",
		classes = { "padded" },
		children = options,
	},
})
