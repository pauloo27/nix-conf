#!/usr/bin/env bash
sudo cp ./hyprland.desktop /usr/share/wayland-sessions/hyprland.desktop
sudo cp ./hyprland-wrapper /usr/local/bin/hyprland-wrapper
sudo chmod +x /usr/local/bin/hyprland-wrapper

# Link systemd user units
mkdir -p ~/.config/systemd/user
find ~/.config/systemd/user -xtype l -delete
for unit in ~/.nix-profile/share/systemd/user/*; do
  unit_name=$(basename "$unit")
  ln -s "$unit" ~/.config/systemd/user/"$unit_name"
done
