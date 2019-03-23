#!/usr/bin/env bash

# Shell
alias reload!='. ~/.bashrc'

# Update Homebrew
alias brewup='brew upgrade && brew cask upgrade'

alias brc="echo -e '$YellowRunning Rails console in sandbox mode...$Color_Off'; bin/rails c --sandbox"
alias brs="bin/rails s"
alias bx='bundle exec'
alias cat='bat'
alias git-delete-count="$DOTFILES_PATH/bin/git_delete_count.rb"
alias mine="open -a RubyMine"
alias libyear="libyear-bundler"
alias reset="clear && printf '\e[3J'"
alias timestamp='date "+%Y%m%d%H%M%S"'

# Overrides
alias git=hub
alias ls='ls -a'

# Cuz i just can't anymore
alias heroky=heroku
