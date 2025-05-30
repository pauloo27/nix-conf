#!/usr/bin/env bash

set -euo pipefail

# Define colors
GREEN='\033[1;32m'
BLUE='\033[1;34m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
RESET='\033[0m'

USER_NAME="paulo"
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

info "Applying system configuration..."
./apply.sh

info "Applying user configuration for $USER_NAME..."
./apply-user.sh "$USER_NAME"

info "Cleaning up old generations..."
./clean-up-old.sh

info "Storing update timestamp..."
date -u +"Last update: %Y-%m-%d %H:%M UTC" > "$UPDATE_LOG"

success "System updated successfully."
