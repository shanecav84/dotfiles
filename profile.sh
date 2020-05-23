#!/usr/bin/env bash

# Mah dotfiles
for f in $DOTFILES_PATH/lib/*.sh; do source $f; done

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

