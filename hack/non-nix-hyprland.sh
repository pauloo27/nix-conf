#!/usr/bin/env bash
sudo cp ./hyprland.desktop /usr/share/wayland-sessions/hyprland.desktop
sudo ln -s ~/.nix-profile/bin/Hyprland /usr/local/bin/Hyprland
sudo ln -s ~/.nix-profile/bin/uwsm /usr/local/bin/uwsm
sudo cp ~/.nix-profile/etc/pam.d/hyprlock /etc/pam.d/hyprlock

# Link systemd user units
mkdir -p ~/.config/systemd/user
for unit in ~/.nix-profile/share/systemd/user/*; do
  unit_name=$(basename "$unit")
  ln -s "$unit" ~/.config/systemd/user/"$unit_name"
done
