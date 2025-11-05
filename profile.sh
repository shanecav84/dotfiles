#!/usr/bin/env zsh

export PROMPT="%t [%F{cyan}%m%f] %F{cyan}%1d %F{red}>%F{yellow}>%F{green}>%F{cyan}>%F{blue}>%f "

for f in $(ls $DOTFILES_PATH/lib/*.sh| sort -n); do source $f; done

if type brew &>/dev/null; then
   FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
   autoload -Uz compinit && compinit
 fi

