#!/usr/bin/env bash
HOSTNAME=$(hostname -s)
sudo nixos-rebuild switch --flake .#$HOSTNAME
