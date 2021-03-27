#!/bin/bash
# ---
# dotfiles boostrap
#

HOMEDIR=$HOME
DOTFILEDIR="$PWD/dotfiles"

find -type d -exec mkdir --parents -- "$HOMEDIR"/{} \;

find -type f -exec ln --symbolic -- "$DOTFILEDIR"/{} "$HOMEDIR"/{} \;

