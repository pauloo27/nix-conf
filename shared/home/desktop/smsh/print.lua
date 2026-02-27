require("wrapper")

load_stylesheet("./print.css")

local save_to_clipboard = true
local is_niri = os.getenv("XDG_SESSION_DESKTOP") == "niri"
local is_recording = os.execute("pgrep wl-screenrec > /dev/null 2>&1") == true

local function take_screenshot(grim_args)
  local cmd
  if save_to_clipboard then
    cmd = "sleep 0.2 && grim " .. grim_args .. " - | wl-copy &"
  else
    local home = os.getenv("HOME")
    local filename = os.date("%Y%m%d-%H%M%S") .. ".png"
    local path = home .. "/medias/pictures/prints/" .. filename
    cmd = "sleep 0.2 && grim " .. grim_args .. " " .. path .. " && echo -n " .. path .. " | wl-copy &"
  end
  os.execute(cmd)
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
    classes = { "print_root" },
    children = {
      -- header
      {
        type = "label",
        text = "Capture",
        classes = { "print_heading" },
      },

      -- select area subheading
      {
        type = "label",
        text = "Select area",
        classes = { "print_subheading" },
      },

      -- screenshot targets
      {
        type = "container",
        orientation = "horizontal",
        halign = "center",
        classes = { "print_actions" },
        children = {
          {
            type = "button",
            icon = "window-new-symbolic",
            tooltip = "Pick a window to capture",
            classes = { "print_action_btn" },
            action = function()
              if is_niri then
                local cmd = "sleep 0.2 && ID=$(niri msg -j pick-window | jq -r '.id') && "
                -- TODO: copy path to clipboard when saving to file (niri overrides clipboard)
                local disk = save_to_clipboard and "false" or "true"
                cmd = cmd .. "niri msg action screenshot-window --id $ID --write-to-disk " .. disk .. " &"
                os.execute(cmd)
                os.exit(0)
              else
                print("oof")
              end
            end,
          },
          {
            type = "button",
            icon = "video-display-symbolic",
            tooltip = "Capture a screen",
            classes = { "print_action_btn" },
            action = function()
              take_screenshot('-g "$(slurp -o)"')
            end,
          },
          {
            type = "button",
            icon = "edit-select-symbolic",
            tooltip = "Select an area",
            classes = { "print_action_btn" },
            action = function()
              take_screenshot('-g "$(slurp)"')
            end,
          },
        },
      },

      -- separator
      {
        type = "container",
        orientation = "horizontal",
        halign = "fill",
        classes = { "print_separator" },
        children = {},
      },

      -- save destination
      {
        type = "label",
        text = "Save to",
        classes = { "print_subheading" },
      },
      {
        type = "togglebuttongroup",
        orientation = "horizontal",
        halign = "center",
        classes = { "print_save_group" },
        buttons = {
          {
            icon = "edit-paste-symbolic",
            active = save_to_clipboard,
            classes = { "print_save_btn" },
            tooltip = "Copy to clipboard",
            action = function(state)
              save_to_clipboard = state == "true"
            end,
          },
          {
            icon = "document-save-symbolic",
            active = not save_to_clipboard,
            tooltip = "Save to ~/medias/pictures/prints/",
            classes = { "print_save_btn" },
          },
        },
      },

      -- separator
      {
        type = "container",
        orientation = "horizontal",
        halign = "fill",
        classes = { "print_separator" },
        children = {},
      },

      -- color picker
      {
        type = "label",
        text = "Tools",
        classes = { "print_subheading" },
      },
      {
        type = "container",
        orientation = "horizontal",
        halign = "center",
        classes = { "print_actions" },
        children = {
          {
            type = "button",
            icon = "color-select-symbolic",
            tooltip = "Pick a color from the screen",
            classes = { "print_action_btn" },
            action = function()
              os.execute("sleep 0.2 && hyprpicker -a &")
              os.exit(0)
            end,
          },
          {
            type = "button",
            icon = is_recording and "media-playback-stop-symbolic" or "media-record-symbolic",
            tooltip = is_recording and "Stop recording" or "Record the screen",
            classes = { "print_action_btn" },
            action = function()
              if is_recording then
                os.execute("pkill wl-screenrec")
              else
                os.execute("wl-screenrec -g \"$(slurp -o)\" --codec hevc -b '2 MB' -m 27 -f " ..
                os.getenv("HOME") .. "/medias/videos/recordings/" .. os.date("%Y%m%d-%H%M%S") .. ".mp4 &")
              end
              os.exit(0)
            end,
          },
          {
            type = "button",
            icon = "document-edit-symbolic",
            tooltip = "Edit clipboard image with Swappy",
            classes = { "print_action_btn" },
            action = function()
              os.execute("sleep 0.2 && wl-paste | swappy -f - &")
              os.exit(0)
            end,
          },
        },
      },
    },
  },
})
