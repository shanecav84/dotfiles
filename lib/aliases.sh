#!/usr/bin/env bash

# Shell
alias reload!='. ~/.bash_profile'

# Update Homebrew
alias brewup='brew update && brew upgrade && brew cleanup'

alias brs="bin/rails s"
alias bunup="$DOTFILES_PATH/bin/bunup.rb"
alias cdcs="cd ~/Code/dcs/dcs-manager"
alias cdj="cd ~/Code/classroomdj"
alias reset="clear && printf '\e[3J'"
alias timestamp='date "+%Y%m%d%H%M%S"'
alias httpstatus="$DOTFILES_PATH/bin/httpstatus.rb"

source "$DOTFILES_PATH/lib/jb_rubygem_page.sh"
alias rg="jb_rubygem_page"

# Overrides
alias git=hub
alias ls='ls -alh'

# Cuz i just can't anymore
alias heroky=heroku
