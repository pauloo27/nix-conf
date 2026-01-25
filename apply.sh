#!/usr/bin/env bash
HOSTNAME=$(cat /etc/hostname)
nix build .#homeConfigurations.$HOSTNAME.activationPackage && ./result/activate
