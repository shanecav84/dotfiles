#!/usr/bin/env bash

# Mah dotfiles
for f in $DOTFILES_PATH/lib/*.sh; do source $f; done

if [ -f /usr/local/opt/git/etc/bash_completion.d/git-completion.bash ]; then
  . /usr/local/opt/git/etc/bash_completion.d/git-completion.bash
else
  echo "Expected this machine to have git-completion at /usr/local/opt/git/etc/bash_completion.d/git-completion.bash"
fi

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

