#!/usr/bin/env bash

set -euo pipefail

# Define colors
GREEN='\033[1;32m'
BLUE='\033[1;34m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
RESET='\033[0m'

HOSTNAME=$(cat /etc/hostname)
UPDATE_LOG="last-update.txt"

# Source shared configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/nixos-hosts.sh"

info() {
  echo -e "${BLUE}[INFO]${RESET} $1"
}

success() {
  echo -e "${GREEN}[DONE]${RESET} $1"
}

warning() {
  echo -e "${YELLOW}[WARN]${RESET} $1"
}

error() {
  echo -e "${RED}[ERROR]${RESET} $1"
}

is_nixos() {
  for system in "${NIXOS_HOSTNAMES[@]}"; do
    if [[ "$HOSTNAME" == "$system" ]]; then
      return 0
    fi
  done
  return 1
}

info "Updating flake inputs..."
nix flake update

info "Updating dev environment flakes..."
for dev_env in ./dev/*; do
  if [[ -d "$dev_env" && -f "$dev_env/flake.nix" ]]; then
    env_name=$(basename "$dev_env")
    info "  Updating $env_name..."
    (cd "$dev_env" && nix flake update)
    success "  $env_name updated"
  fi
done

if is_nixos; then
  info "Applying system configuration for $HOSTNAME..."
  ./apply-os.sh
else
  warning "Skipping system configuration (not a NixOS system)"
fi

info "Applying home configuration for $HOSTNAME..."
./apply.sh

success "System updated successfully."
