require("wrapper")

---@class ConfirmOptions
---@field title? string Window title
---@field enable_vim_keys? boolean Enable vim keybindings (default: true)
---@field enable_esc_as_exit? boolean Allow ESC to exit (default: true)
---@field exit_on_close? boolean Exit on window close
---@field present? boolean Present the window
---@field message? string Confirmation message (default: "Are you sure?")
---@field tooltip? string Tooltip for the message label
---@field yes_text? string Text for yes button (default: "Yes")
---@field yes_tooltip? string Tooltip for yes button (default: "Yes!")
---@field on_yes? fun() Callback when yes is clicked (default: exit with code 0)
---@field no_text? string Text for no button (default: "No")
---@field no_tooltip? string Tooltip for no button (default: "No")
---@field on_no? fun() Callback when no is clicked (default: exit with code 1)

---Show a confirmation dialog with Yes/No buttons
---@param opts ConfirmOptions Options for the confirm dialog
---@return nil
function confirm(opts)
	opts = opts or {}

	new_window({
		title = opts.title or "SMSH: Confirm",
		enable_vim_keys = opts.enable_vim_keys ~= false,
		enable_esc_as_exit = opts.enable_esc_as_exit ~= false,
		exit_on_close = opts.exit_on_close,
		present = opts.present,
		root = {
			type = "container",
			orientation = "vertical",
			children = {
				{
					type = "label",
					text = opts.message or "Are you sure?",
					tooltip = opts.tooltip or "",
				},
				{
					type = "button",
					text = opts.yes_text or "Yes",
					tooltip = opts.yes_tooltip or "Yes!",
					action = opts.on_yes or function()
						os.exit(0)
					end,
				},
				{
					type = "button",
					text = opts.no_text or "No",
					tooltip = opts.no_tooltip or "No",
					action = opts.on_no or function()
						os.exit(1)
					end,
				},
			},
		},
	})
end

---@class PromptOptions
---@field title? string Window title (default: "SMSH: Prompt")
---@field enable_vim_keys? boolean Enable vim keybindings (default: false)
---@field enable_esc_as_exit? boolean Allow ESC to exit (default: true)
---@field exit_on_close? boolean Exit on window close
---@field present? boolean Present the window
---@field orientation? ContainerOrientation Layout orientation (default: "horizontal")
---@field default_text? string Default text in the entry field
---@field tooltip? string Tooltip for the entry field (default: "Type here")

---Show a prompt dialog with a text entry field
---@param opts PromptOptions Options for the prompt dialog
---@return nil
function prompt(opts)
	opts = opts or {}

	new_window({
		title = opts.title or "SMSH: Prompt",
		enable_vim_keys = opts.enable_vim_keys or false,
		enable_esc_as_exit = opts.enable_esc_as_exit ~= false,
		exit_on_close = opts.exit_on_close,
		present = opts.present,
		root = {
			type = "container",
			orientation = opts.orientation or "horizontal",
			children = {
				{
					type = "entry",
					text = opts.default_text or "",
					tooltip = opts.tooltip or "Type here",
					action = function(value)
						print(value)
						os.exit(0)
					end,
				},
			},
		},
	})
end

---Run a command unless pacman is running
---@param cmd string Command to execute
---@return nil
function run_unless_pacman(cmd)
	local lockfile = io.open("/var/lib/pacman/db.lck", "r")
	if lockfile then
		lockfile:close()
		os.execute("notify-send 'Cannot do that while pacman is running' -i system-reboot -u critical")
	else
		os.execute(cmd)
	end
end
