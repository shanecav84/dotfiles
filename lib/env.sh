#!/usr/bin/env bash
export EDITOR="vi"

# Mah dotfiles
export PATH=$DOTFILES_PATH/bin:${PATH}

# Homebrew, presumably
export PATH=$(echo $PATH | sed 's|/usr/local/bin||; s|/usr/local/sbin||; s|::|:|; s|^:||; s|\(.*\)|/usr/local/bin:/usr/local/sbin:\1|')

# Python `virtualenv` stuff
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Sites/django

# Locales
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Lunchy gem
LUNCHY_DIR=$(dirname `gem which lunchy`)/../extras
