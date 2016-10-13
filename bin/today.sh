#!/usr/bin/env bash

printf "Checking updates...\n"

brew_output() {
    printf "# Homebrew\n"

    brew update > /dev/null
    local output=$(brew outdated)

    if [[ ! -z $output ]]; then
        brew outdated
    fi
}

bundle_output() {
    printf "# DCS bundler\n"

    local DCS_PATH="$HOME/Dev/dcs/dcs-manager"
    local output=$($DCS_PATH/bin/bundle outdated --parseable)

    if [[ ! -z $output ]]; then
        printf $output
    fi
}

brew_output
printf "\n"
bundle_output
printf "\n\n"
