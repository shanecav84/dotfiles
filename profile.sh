#!/usr/bin/env bash

# Mah dotfiles
for f in $DOTFILES_PATH/lib/*.sh; do source $f; done

# ================ Bash Completion =========================

if [ -f /usr/local/etc/bash_completion ]; then
    . /usr/local/etc/bash_completion
fi

# ================ Git Prompt ==============================
# https://github.com/magicmonty/bash-git-prompt

if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
    __GIT_PROMPT_DIR=$(brew --prefix)/opt/bash-git-prompt/share
    source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

source $DOTFILES_PATH/git-completion.bash
