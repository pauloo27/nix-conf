#!/usr/bin/env bash
BINDIR="/usr/local/bin"
DESKTOP="hyprland"
if [ "$(whoami)" = "work" ]; then
  BINDIR="/usr/local/bin/work"
  DESKTOP="hyprland-work"
  sudo mkdir -p "$BINDIR"
fi

sudo cp ./${DESKTOP}.desktop /usr/share/wayland-sessions/${DESKTOP}.desktop
sudo ln -s ~/.nix-profile/bin/Hyprland "$BINDIR/Hyprland"
sudo ln -s ~/.nix-profile/bin/uwsm "$BINDIR/uwsm"

# Link systemd user units
mkdir -p ~/.config/systemd/user
for unit in ~/.nix-profile/share/systemd/user/*; do
  unit_name=$(basename "$unit")
  ln -s "$unit" ~/.config/systemd/user/"$unit_name"
done
