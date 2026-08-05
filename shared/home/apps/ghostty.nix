{ ... }:
{
  xdg.configFile."ghostty/config.ghostty".text = ''
    window-inherit-working-directory = false

    font-family = Comic Code
    font-style = Medium
    font-style-bold = Bold
    font-style-italic = Medium Italic
    font-style-bold-italic = Bold Italic
    font-feature = -calt, -liga, -dlig

    theme = Rose Pine
    background-opacity = 0.9
    background-blur = true

    confirm-close-surface = false
  '';
}
