{ pkgs, lib, ... }:
let
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
  settings = if isDarwin then ./settings-darwin.json else ./settings-linux.json;
in
{
  # macOS looks for it under Application Support, and the display area differs
  # per host anyway, so each platform gets its own profile.
  home.file = lib.mkIf isDarwin {
    "Library/Application Support/OpenTabletDriver/settings.json".source = settings;
  };

  xdg.configFile = lib.mkIf (!isDarwin) {
    "OpenTabletDriver/settings.json".source = settings;
  };
}
