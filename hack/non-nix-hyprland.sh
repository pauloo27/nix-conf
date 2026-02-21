#!/usr/bin/env bash
SUFFIX=""
if [ "$(whoami)" = "work" ]; then
  SUFFIX="-work"
fi

sudo cp ./hyprland${SUFFIX}.desktop /usr/share/wayland-sessions/hyprland${SUFFIX}.desktop
sudo ln -s ~/.nix-profile/bin/Hyprland /usr/local/bin/Hyprland$SUFFIX
sudo ln -s ~/.nix-profile/bin/uwsm /usr/local/bin/uwsm$SUFFIX

# Link systemd user units
mkdir -p ~/.config/systemd/user
for unit in ~/.nix-profile/share/systemd/user/*; do
  unit_name=$(basename "$unit")
  ln -s "$unit" ~/.config/systemd/user/"$unit_name"
done
