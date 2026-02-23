#!/usr/bin/env bash

set -euo pipefail

HOSTNAME=$(cat /etc/hostname)

# Source shared configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/hosts.sh"

is_nixos() {
  for system in "${NIXOS_HOSTNAMES[@]}"; do
    if [[ "$HOSTNAME" == "$system" ]]; then
      return 0
    fi
  done
  return 1
}

if is_nixos; then
  echo "Cleaning up system generations..."
  sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +5
fi

echo "Cleaning up old home-manager generations..."
nix-env --delete-generations +5

echo "Running garbage collection..."
if is_nixos; then
  sudo nix-collect-garbage -d
else
  nix-collect-garbage -d
fi
