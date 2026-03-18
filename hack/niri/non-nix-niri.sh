#!/usr/bin/env bash
sudo cp ./niri.desktop /usr/share/wayland-sessions/niri.desktop
sudo cp ./niri-session-wrapper /usr/local/bin/niri-session-wrapper
sudo chmod +x /usr/local/bin/niri-session-wrapper

# Link systemd user units
mkdir -p ~/.config/systemd/user
find ~/.config/systemd/user -xtype l -delete
for unit in ~/.nix-profile/share/systemd/user/*; do
  unit_name=$(basename "$unit")
  ln -s "$unit" ~/.config/systemd/user/"$unit_name"
done
