#!/usr/bin/env bash

PS1="$Cyan\W$Color_Off\n$Red>$Color_Off$IPurple>$Color_Off$Yellow>$Color_Off$Green>$Color_Off$Cyan>$Color_Off "

# bash-git-prompt
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_SHOWCOLORHINTS="1"
GIT_PROMPT_ONLY_IN_REPO=1
GIT_PROMPT_START="$Green\T"
GIT_PROMPT_END=" $PS1"
GIT_PROMPT_COMMAND_OK="blah"
