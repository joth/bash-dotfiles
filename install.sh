#!/usr/bin/env bash

readonly __DIR__="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
readonly BASH_PROFILE="$__DIR__/bash/modules/bashrc_dispatch/bashrc_dispatch"

if [ ! -f "$BASH_PROFILE" ]; then
  echo "Missing $BASH_PROFILE. Did you intialize and update submodules?"
  exit 1
fi

function create_symbolic_link () {
  local target="$1"
  local link_name="$2"

  echo "Creating symbolink link between $target and $link_name"
  ln -sf "$target" "$link_name"
}

profiles=( ".bash_profile" ".bashrc" ".bash_login" )
for profile in "${profiles[@]}"
do
  create_symbolic_link "$BASH_PROFILE" "$HOME/$profile"
done
