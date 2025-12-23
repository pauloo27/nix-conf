#!/usr/bin/env bash
HOSTNAME=$(cat /etc/hostname)
sudo nixos-rebuild switch --flake .#$HOSTNAME
