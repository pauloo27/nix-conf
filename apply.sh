#!/usr/bin/env bash
HOSTNAME=$(cat /etc/hostname)
USER=$(whoami)

if [ "$USER" != "paulo" ]; then
  FLAKE_KEY="$HOSTNAME-$USER"
else
  FLAKE_KEY="$HOSTNAME"
fi

nix build .#homeConfigurations.$FLAKE_KEY.activationPackage && ./result/activate

# Pre-build dev shells so they're cached in the nix store
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/hosts.sh"

should_cache() {
  for host in "${CACHE_DEV_SHELLS[@]}"; do
    if [[ "$HOSTNAME" == "$host" ]]; then
      return 0
    fi
  done
  return 1
}

if [ "$1" != "--skip-dev" ] && should_cache; then
  SYSTEM=$(nix eval --impure --raw --expr 'builtins.currentSystem')
  for dev in dev/*/; do
    echo "Caching dev shell: $dev"
    nix build "./${dev}#devShells.${SYSTEM}.default" --no-link &
  done
  wait
fi
