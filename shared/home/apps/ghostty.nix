{ ... }:
{
  # ghostty itself is installed outside nix (the macOS app), we only manage the
  # config. the file is named config.ghostty since 1.2.3 (was config before).
  xdg.configFile."ghostty/config.ghostty".text = ''
    # open new windows at $HOME instead of inheriting the spawning cwd
    working-directory = home

    theme = Rose Pine
    background-opacity = 0.9

    # cmd+q closes the window, quitting moves to cmd+shift+q
    keybind = cmd+q=close_window
    keybind = cmd+shift+q=quit
  '';
}
