#!/usr/bin/env bash
BINDIR="/usr/local/bin"
DESKTOP="niri"
if [ "$(whoami)" = "work" ]; then
  BINDIR="/usr/local/bin/work"
  DESKTOP="niri-work"
  sudo mkdir -p "$BINDIR"
fi

sudo cp ./${DESKTOP}.desktop /usr/share/wayland-sessions/${DESKTOP}.desktop
sudo ln -s ~/.nix-profile/bin/niri-session "$BINDIR/niri-session"

# Link systemd user units
mkdir -p ~/.config/systemd/user
find ~/.config/systemd/user -xtype l -delete
for unit in ~/.nix-profile/share/systemd/user/*; do
  unit_name=$(basename "$unit")
  ln -s "$unit" ~/.config/systemd/user/"$unit_name"
done
