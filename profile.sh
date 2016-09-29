#!/usr/bin/env bash

# Mah dotfiles
for f in $DOTFILES_PATH/lib/*.sh; do source $f; done

export PATH=$(echo $PATH | sed 's|/usr/local/bin||; s|/usr/local/sbin||; s|::|:|; s|^:||; s|\(.*\)|/usr/local/bin:/usr/local/sbin:\1|')

GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_SHOWCOLORHINTS="1"

if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
    source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

export PATH="/usr/local/sbin:$PATH"
export PATH=$DOTFILES_PATH/bin:${PATH}

# Python virtualenv stuff
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Sites/django
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then source /usr/local/bin/virtualenvwrapper.sh; fi

LUNCHY_DIR=/usr/local/lib/ruby/gems/2.2.0/gems/lunchy-0.10.3/lib/../extras
   if [ -f /lunchy-completion.bash ]; then
     . /lunchy-completion.bash
   fi

source git-completion.bash
