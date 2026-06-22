{ pkgs, ... }:
{
  home.packages = [
    pkgs.nerd-fonts.symbols-only
    pkgs.ubuntu-sans-mono
    pkgs.noto-fonts-color-emoji
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [
        "Comic Code Medium"
        "Ubuntu Sans Mono"
      ];
      emoji = [ "Noto Color Emoji" ];
    };
    configFile.prefer-noto-color-emoji = {
      enable = true;
      priority = 60;
      label = "prefer-noto-color-emoji";
      text = ''
        <?xml version="1.0"?>
        <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
        <fontconfig>
          <description>
            Prefer Noto Color Emoji over Symbola/etc. for emoji and flag
            glyphs in all generic families. Loaded before 65-gdouros-symbola.
          </description>
          <alias binding="strong">
            <family>sans-serif</family>
            <prefer><family>Noto Color Emoji</family></prefer>
          </alias>
          <alias binding="strong">
            <family>serif</family>
            <prefer><family>Noto Color Emoji</family></prefer>
          </alias>
          <alias binding="strong">
            <family>monospace</family>
            <prefer><family>Noto Color Emoji</family></prefer>
          </alias>
        </fontconfig>
      '';
    };
    configFile.symbols-nerd-font-block-non-mono = {
      enable = true;
      priority = 90;
      label = "symbols-nerd-font-block-non-mono";
      text = ''
        <?xml version="1.0"?>
        <!DOCTYPE fontconfig SYSTEM "fonts.dtd">

        <fontconfig>
          <description>
            Reject non-mono Symbols Nerd Font to avoid it being used as a fallback
          </description>

          <!-- Reject Symbols Nerd Font (non-mono) -->
          <selectfont>
            <rejectfont>
              <pattern>
                <patelt name="family">
                  <string>Symbols Nerd Font</string>
                </patelt>
              </pattern>
            </rejectfont>
          </selectfont>
        </fontconfig>
      '';
    };
  };
}
