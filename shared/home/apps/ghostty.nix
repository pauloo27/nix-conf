{ ... }:
{
  xdg.configFile."ghostty/config.ghostty".text = ''
    window-inherit-working-directory = false

    theme = Rose Pine
    background-opacity = 0.9
    background-blur = true

    confirm-close-surface = false

    keybind = cmd+q=close_window
    keybind = cmd+shift+q=quit
  '';
}
