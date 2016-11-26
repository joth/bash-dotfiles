#!/usr/bin/env bash

readonly __DIR__="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
readonly BASH_PROFILE="$__DIR__/bash/modules/bashrc_dispatch/bashrc_dispatch"
readonly BASH_DOTFILES="$__DIR__/bash/dotfiles"
readonly BASH_PRIVATE_BIN="$__DIR__/bash/bin"

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

dotfiles="$(find "$BASH_DOTFILES" -maxdepth 1 -type f -printf "%f\n")"
for dotfile in ${dotfiles}
do
  create_symbolic_link "$BASH_DOTFILES/$dotfile" "$HOME/.$dotfile"
done

mkdir -p "$HOME/bin"
executables="$(find "$BASH_PRIVATE_BIN" -maxdepth 1 -type f -printf "%f\n")"
for executable in "${executables[@]}"
do
  create_symbolic_link "$BASH_PRIVATE_BIN/$executable" "$HOME/bin/$executable"
done
