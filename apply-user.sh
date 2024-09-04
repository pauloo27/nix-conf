#!/usr/bin/env bash
USER_TO_APPLY=$1
[ -z $USER_TO_APPLY ] && echo "missing user name" && exit 1

nix build .#homeConfigurations.$1.activationPackage && ./result/activate
