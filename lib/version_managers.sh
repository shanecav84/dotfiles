#!/usr/bin/env zsh

# Node
if which nodenv > /dev/null; then eval "$(nodenv init -)"; fi

# Python
if which pyenv > /dev/null; then
  export PATH="$HOME/.pyenv/bin:$PATH";
  eval "$(pyenv init -)";
fi

# Ruby
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
if which rv > /dev/null; then eval "$(rv shell init zsh)"; fi