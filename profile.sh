#!/usr/bin/env bash

# Mah dotfiles
for f in $DOTFILES_PATH/lib/*.sh; do source $f; done

# ================ Bash Completion =========================
if [ -f /usr/local/etc/bash_completion ]; then . /usr/local/etc/bash_completion; fi
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

source $DOTFILES_PATH/git-completion.bash
