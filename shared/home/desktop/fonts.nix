{ pkgs, ... }:
{
  home.packages = [
    pkgs.nerd-fonts.symbols-only
    pkgs.ubuntu-sans-mono
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [
        "Comic Code Medium"
        "Ubuntu Sans Mono"
      ];
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
