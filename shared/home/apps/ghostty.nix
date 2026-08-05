{ ... }:
{
  xdg.configFile."ghostty/config.ghostty".text = ''
    window-inherit-working-directory = false

    font-family = Comic Code
    font-style = Medium
    font-style-bold = Bold
    font-style-italic = Medium Italic
    font-style-bold-italic = Bold Italic
    # nerd font icons, from the face installed by the host rather than ghostty's
    # bundled fallback. mono so every icon is one cell wide.
    font-family = Symbols Nerd Font Mono
    font-feature = -calt, -liga, -dlig

    theme = Rose Pine
    background-opacity = 0.9
    background-blur = true

    confirm-close-surface = false
  '';
}
