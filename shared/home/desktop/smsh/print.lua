require("wrapper")

load_stylesheet("./style.css")

local save_to_clipboard = true

local function take_screenshot(target)
  if save_to_clipboard then
    os.execute("grimblast copy " .. target .. " &")
  else
    local home = os.getenv("HOME")
    local filename = os.date("%Y%m%d-%H%M%S") .. ".png"
    local path = home .. "/medias/pictures/prints/" .. filename
    local wl = io.popen("wl-copy", "w")
    wl:write(path)
    wl:close()
    os.execute("grimblast save " .. target .. " " .. path .. " &")
  end
  os.exit(0)
end

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
        halign = "center",
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
              take_screenshot("active")
            end,
          },
          {
            type = "button",
            text = "󰩬",
            tooltip = "Print a specific area",
            classes = { "main_button" },
            action = function()
              take_screenshot("area")
            end,
          },
          {
            type = "button",
            text = "󰹑",
            tooltip = "Print the entire screen",
            classes = { "main_button" },
            action = function()
              take_screenshot("screen")
            end,
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
              save_to_clipboard = state == "true"
            end,
          },
          {
            text = "",
            active = not save_to_clipboard,
            tooltip = "Save to file",
            classes = { "toggle_button" },
            -- no action since the group handles exclusivity
          },
        },
      },
    },
  },
})
