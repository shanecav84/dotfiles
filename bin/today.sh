#!/usr/bin/env bash

last_updated=$(<$DOTFILES_PATH/tmp/today_last_updated.txt)
now=$(date +%s)
hours_since=$((($now-$last_updated)/60/60))
DCS_PATH="$HOME/Dev/dcs/dcs-manager"

brew_output() {
    printf "# Homebrew\n"
    brew outdated
}

bundle_output() {
    printf "# DCS bundler\n"
    $DCS_PATH/bin/bundle outdated --parseable
}

if [[ $hours_since -gt 3 || $1 -eq "now" ]]; then
    brew_output
    printf "\n"
    bundle_output

    echo $now > $last_updated
fi
