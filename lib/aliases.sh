#!/usr/bin/env bash

# Shell
alias reload!='. ~/.bash_profile'

# Update Homebrew
alias brewup='brew update && brew upgrade && brew cleanup'

alias brc="echo -e '$YellowRunning Rails console in sandbox mode...$Color_Off'; bin/rails c --sandbox"
alias brs="bin/rails s"
alias bunup="$DOTFILES_PATH/bin/bunup.rb"
alias cdcs="cd ~/Code/dcs/dcs-manager"
alias cdj="cd ~/Code/classroomdj"
alias git-delete-count="$DOTFILES_PATH/bin/git_delete_count.rb"
alias libyear="libyear-bundler"
alias reset="clear && printf '\e[3J'"
alias timestamp='date "+%Y%m%d%H%M%S"'

# Overrides
alias git=hub
alias ls='ls -alh'

# Cuz i just can't anymore
alias heroky=heroku
