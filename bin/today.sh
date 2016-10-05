#!/usr/bin/env bash

brew_output() {
    brew update > /dev/null
    local output=$(brew outdated)

    if [[ ! -z $output ]]; then
        printf "# Homebrew\n"
        brew outdated
    fi
}

bundle_output() {
    local DCS_PATH="$HOME/Dev/dcs/dcs-manager"
    local output=$($DCS_PATH/bin/bundle outdated --parseable)

    if [[ ! -z $output ]]; then
        printf "# DCS bundler\n"
        printf $output
    fi
}

brew_output
printf "\n"
bundle_output
