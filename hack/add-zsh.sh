#!/bin/bash
set -e

ZSH_PATH="$HOME/.nix-profile/bin/zsh"

if [ ! -f "$ZSH_PATH" ]; then
  echo "Error: Zsh not found at $ZSH_PATH"
  exit 1
fi

if grep -q "^$ZSH_PATH$" /etc/shells 2>/dev/null; then
  echo "$ZSH_PATH already in /etc/shells"
else
  echo "Adding $ZSH_PATH to /etc/shells"
  echo "$ZSH_PATH" | sudo tee -a /etc/shells > /dev/null
fi

echo "Run: chsh -s $ZSH_PATH"
