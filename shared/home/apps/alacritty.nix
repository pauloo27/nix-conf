{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    theme = "rose_pine";
    settings = {

      window = {
        opacity = 0.9;
        padding = {
          x = 10;
          y = 10;
        };
      };

      font = {
        normal = {
          # fallback to default monospaced
          style = "Regular";
        };
        size = 10;
      };

      cursor = {
        style = {
          blinking = "On";
        };
      };

      mouse = {
        hide_when_typing = true;
      };

      # alacritty sends a bare \r for shift+enter, so tmux has no distinct key
      # to pass through. emit the kitty-protocol sequence explicitly instead.
      keyboard.bindings = [
        {
          key = "Return";
          mods = "Shift";
          chars = "[13;2u";
        }
      ];
    };
  };
}
