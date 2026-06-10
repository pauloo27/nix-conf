#!/usr/bin/env bash
HOSTNAME=$(cat /etc/hostname)
USER=$(whoami)

if [ "$USER" != "paulo" ]; then
  FLAKE_KEY="$HOSTNAME-$USER"
else
  FLAKE_KEY="$HOSTNAME"
fi

home-manager news --flake ".#$FLAKE_KEY"
