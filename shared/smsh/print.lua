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
		classes = { "padded" },
		children = {
			{
				type = "label",
				text = "Pick an option",
				classes = { "title" },
			},
			{
				type = "container",
				orientation = "horizontal",
				children = {
					{
						type = "button",
						text = "󰴱",
						tooltip = "Pick a color",
						classes = { "main_button" },
						action = function()
							os.execute("hyprpicker -a &")
							os.exit(0)
						end,
					},
					{
						type = "button",
						text = "",
						tooltip = "Print the active window",
						classes = { "main_button" },
						action = function()
							-- TODO:
							print(save_to_clipboard)
						end,
					},
					{
						type = "button",
						text = "󰩬",
						tooltip = "Print a specific area",
						classes = { "main_button" },
						action = function() end,
					},
					{
						type = "button",
						text = "󰹑",
						tooltip = "Print the entire screen",
						classes = { "main_button" },
						action = function() end,
					},
				},
			},
			{
				type = "label",
				text = "Where to save",
				classes = { "title" },
			},
			{
				type = "togglebuttongroup",
				orientation = "horizontal",
				halign = "center",
				buttons = {
					{
						text = "",
						active = save_to_clipboard,
						classes = { "toggle_button" },
						tooltip = "Save to clipboard",
						action = function(state)
							save_to_clipboard = state
						end,
					},
					{
						text = "",
						active = false,
						tooltip = "Save to file",
						classes = { "toggle_button" },
						-- no action since the group handles exclusivity
					},
				},
			},
		},
	},
})
