require("helpers")
require("wrapper")

load_stylesheet("./style.css")

local save_to_clipboard = true

new_window({
	title = "SMSH: Print",
	enable_vim_keys = true,
	enable_esc_as_exit = true,
	present = true,
	exit_on_close = true,
	root = {
		type = "container",
		orientation = "vertical",
		children = {
			{
				type = "label",
				text = "Pick an option",
			},
			{
				type = "container",
				orientation = "horizontal",
				children = {
					{
						type = "button",
						text = "󰴱",
						tooltip = "Pick a color",
						action = function()
							os.execute("hyprpicker -a &")
							os.exit(0)
						end,
					},
					{
						type = "button",
						text = "",
						tooltip = "Print the active window",
						action = function()
							-- TODO:
							print(save_to_clipboard)
						end,
					},
					{
						type = "button",
						text = "󰩬",
						tooltip = "Print a specific area",
						action = function() end,
					},
					{
						type = "button",
						text = "󰹑",
						tooltip = "Print the entire screen",
						action = function() end,
					},
				},
			},
			{
				type = "togglebuttongroup",
				orientation = "horizontal",
				halign = "center",
				buttons = {
					{
						text = "",
						active = save_to_clipboard,
						action = function(state)
							save_to_clipboard = state
						end,
					},
					{
						text = "",
						active = false,
						-- no action since the group handles exclusivity
					},
				},
			},
		},
	},
})
