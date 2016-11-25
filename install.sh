#!/usr/bin/env bash

readonly __DIR__="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
readonly BASHRC_DISPATCH="$__DIR__/bash/modules/bashrc_dispatch/bashrc_dispatch"

if [ ! -f "$BASHRC_DISPATCH" ]; then
  echo "Missing $BASHRC_DISPATCH. Did you intialize and update submodules?"
  exit 1
fi

profiles=( ".bash_profile" ".bashrc" ".bash_login" )
for profile in "${profiles[@]}"
do
  ln -sf "$BASHRC_DISPATCH" "$HOME/$profile"
done
