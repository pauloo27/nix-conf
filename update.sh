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

info "Updating flake inputs..."
nix flake update

info "Applying system configuration for $HOSTNAME..."
./apply-os.sh

info "Applying home configuration for $HOSTNAME..."
./apply.sh

info "Cleaning up old generations..."
./clean-up.sh

success "System updated successfully."
