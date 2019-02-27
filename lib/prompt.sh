#!/usr/bin/env bash

# https://gist.github.com/jstn/d249cc4bbb76e0e06ccc6d6a11ff5f04
function git_prompt() {
  local dirty=false

  if [[ $(git status --short 2> /dev/null | wc -l) -gt 0 ]]; then
    dirty=true
  fi

  if ! git diff --quiet 2> /dev/null; then
    dirty=true
  fi

  local ref
  ref=$(git symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return
    ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  fi

  if [ "$dirty" = true ]; then
    echo " [$Yellow${ref#refs/heads/}$Color_Off]"
  else
    echo " [${ref#refs/heads/}]"
  fi
}

function prompt() {
    PS1="\@ $Cyan\W$Color_Off$(git_prompt) $Red>$Color_Off$IPurple>$Color_Off$Yellow>$Color_Off$Green>$Color_Off$Cyan>$Color_Off "
}

PROMPT_COMMAND=prompt
