#!/usr/bin/env bash

cyan="\001$(tput setaf 6)\002"
red="\001$(tput setaf 1)\002"
purple="\001$(tput setaf 5)\002"
yellow="\001$(tput setaf 3)\002"
green="\001$(tput setaf 2)\002"
reset_color="\001$(tput sgr0)\002"

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
    echo "@$yellow${ref#refs/heads/}$reset_color"
  else
    echo "@${ref#refs/heads/}"
  fi
}

function prompt() {
    PS1="\@ $cyan\W$reset_color$(git_prompt) $red>$reset_color$purple>$reset_color$yellow>$reset_color$green>$reset_color$cyan>$reset_color "
}

PROMPT_COMMAND=prompt
