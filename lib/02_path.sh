#!/usr/bin/env zsh

path=('/Users/shane.cavanaugh/.dotfiles/bin' $path)
path=('/Users/shane.cavanaugh/.local/bin' $path)

path=('/opt/homebrew/bin' $path)
path=('/opt/homebrew/sbin' $path)
path=('/opt/homebrew/opt/openjdk/bin' $path)
path=('/opt/homebrew/opt/coreutils/libexec/gnubin' $path)

path=('/Users/shane.cavanaugh/.lmstudio/bin' $path)

fpath=(/Users/shane.cavanaugh/.docker/completions $fpath)

export PATH
