{ ... }:
{
  # ghostty itself is installed outside nix (the macOS app), we only manage the
  # config. the file is named config.ghostty since 1.2.3 (was config before).
  xdg.configFile."ghostty/config.ghostty".text = ''
    # open new windows at $HOME instead of inheriting the spawning cwd
    working-directory = home

    theme = Rose Pine
  '';
}
