#!/usr/bin/env bash

PS1="$Red>$IPurple>$Yellow>$Green>$Cyan>$Color_Off "

# bash-git-prompt
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_SHOWCOLORHINTS="1"
GIT_PROMPT_ONLY_IN_REPO=1
GIT_PROMPT_START="$Cyan\T"
GIT_PROMPT_END=" $PS1"
GIT_PROMPT_COMMAND_OK="blah"

PROMPT_COMMAND="today"
