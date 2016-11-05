#!/usr/bin/env bash

# Mah dotfiles
for f in $DOTFILES_PATH/lib/*.sh; do source $f; done

# ================ Bash Completion =========================

if [ -f /usr/local/etc/bash_completion ]; then
  . /usr/local/etc/bash_completion
fi

# ================ Git Prompt ==============================
# https://github.com/magicmonty/bash-git-prompt

if [ -f "/usr/local/opt/bash-git-prompt/share/gitprompt.sh" ]; then
  GIT_PROMPT_THEME=Solarized_NoExitState
  source "/usr/local/opt/bash-git-prompt/share/gitprompt.sh"
fi

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Python `virtualenv` stuff
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then source /usr/local/bin/virtualenvwrapper.sh; fi

# `lunchy` gem
if [ -f $LUNCHY_DIR/lunchy-completion.bash ]; then
 . $LUNCHY_DIR/lunchy-completion.bash
fi

source $DOTFILES_PATH/git-completion.bash
