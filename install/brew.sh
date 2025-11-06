#!/usr/bin/env bash

if ! [ -x "$(command -v brew)" ]; then
    printf "brew not found. Installing brew. \n"
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install
fi

taps=(
    'Homebrew/bundle'
    'caskroom/cask'
)
for tap in ${taps[*]}; do
    brew tap "$tap"
done

brews=(
    'readline'
    'bash'
    'bash-completion'
    'bash-git-prompt'
    'bat'
    'curl'
    'git'
    'heroku'
    'imagemagick'
    'mariadb'
    'nginx'
    'node'
    'nmap'
    'openssl'
    'postgresql'
    'python'
    'python3'
    'rbenv'
    'ruby-build'
    'yarn'
)
for brew in ${brews[*]}; do
    brew install "$brew"
done

casks=(
    '1password'
    'alfred'
    'atom'
    'brave-browser'
    'dash'
    'github-desktop'
    'google-chrome'
    'mailplane'
    'rubymine'
    'skype'
    'slack'
    'spotify'
    'virtualbox'
    'vlc'
)
for cask in ${casks[*]}; do
    brew cask install "$cask"
done
