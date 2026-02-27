{
  pkgs,
  smsh,
  ...
}:
{
  home.packages = [
    smsh.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  xdg.configFile."smsh/confirm.lua".source = ./confirm.lua;
  xdg.configFile."smsh/helpers.lua".source = ./helpers.lua;
  xdg.configFile."smsh/power.lua".source = ./power.lua;
  xdg.configFile."smsh/print.css".source = ./print.css;
  xdg.configFile."smsh/print.lua".source = ./print.lua;
  xdg.configFile."smsh/prompt.css".source = ./prompt.css;
  xdg.configFile."smsh/prompt.lua".source = ./prompt.lua;
  xdg.configFile."smsh/style.css".source = ./style.css;
  xdg.configFile."smsh/wrapper.lua".source = ./wrapper.lua;
}
