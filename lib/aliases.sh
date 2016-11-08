#!/usr/bin/env bash

# Shell
alias reload!='. ~/.bash_profile'
alias today="$DOTFILES_PATH/bin/today.sh"

# Update Homebrew
alias brewup='brew update && brew upgrade && brew cleanup'

alias bunup="$DOTFILES_PATH/bin/bunup.rb"
alias cdcs="cd ~/Dev/dcs/dcs-manager"
alias reset="clear && printf '\e[3J'"

source "$DOTFILES_PATH/lib/jb_rubygem_page.sh"
alias rg="jb_rubygem_page"

# Overrides
alias ls='ls -alh'
