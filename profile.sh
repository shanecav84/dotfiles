#!/usr/bin/env zsh

export PROMPT='%t [%F{cyan}%m%f] %B%F{cyan}%1~%f%b %F{red}>%F{yellow}>%F{green}>%F{cyan}>%F{blue}>%f '

RPROMPT='$(git_prompt_info)'

for f in $(ls $HOME/.dotfiles/lib/*.sh| sort -n); do source $f; done

if type brew &>/dev/null; then
   fpath=($(brew --prefix)/share/zsh-completions $fpath)
   autoload -Uz compinit && compinit
 fi

