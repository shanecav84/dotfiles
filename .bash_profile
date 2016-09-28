export PATH=$(echo $PATH | sed 's|/usr/local/bin||; s|/usr/local/sbin||; s|::|:|; s|^:||; s|\(.*\)|/usr/local/bin:/usr/local/sbin:\1|')

GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_SHOWCOLORHINTS="1"

source ~/.git-prompt.sh

# Mah dotfiles
for f in ~/.dotfiles/*.sh; do source $f; done

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

export PATH="/usr/local/sbin:$PATH"

# Python virtualenv stuff
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Sites/django
source /usr/local/bin/virtualenvwrapper.sh

LUNCHY_DIR=/usr/local/lib/ruby/gems/2.2.0/gems/lunchy-0.10.3/lib/../extras
   if [ -f /lunchy-completion.bash ]; then
     . /lunchy-completion.bash
   fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
