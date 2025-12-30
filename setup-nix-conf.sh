#!/usr/bin/env bash
set -e

NIX_CONF_DIR="$HOME/.config/nix"
NIX_CONF_FILE="$NIX_CONF_DIR/nix.conf"

mkdir -p "$NIX_CONF_DIR"

if [ -f "$NIX_CONF_FILE" ] && grep -q "experimental-features.*nix-command.*flakes" "$NIX_CONF_FILE"; then
  echo "nix.conf already configured"
else
  echo "experimental-features = nix-command flakes" >> "$NIX_CONF_FILE"
  echo "Created $NIX_CONF_FILE"
fi
