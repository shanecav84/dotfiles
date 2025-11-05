#!/usr/bin/env zsh

export PROMPT="%t [%F{cyan}%m%f] $PROMPT"

for f in $(ls $DOTFILES_PATH/lib/*.sh| sort -n); do source $f; done

if type brew &>/dev/null; then
   FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
   autoload -Uz compinit && compinit
 fi

