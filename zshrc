#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

source $HOME/.zalias

path=(
  ./bin
  $HOME/bin
  $HOME/.local/rbenv/{shims,bin}
  /usr/local/{bin,sbin}
  /usr/{bin,sbin}
)

#
# Language Runtime Managers
#

# rbenv
export RBENV_SHELL=zsh
export RBENV_ROOT=$HOME/.local/rbenv
export RUBY_BUILD_CACHE_PATH=$RBENV_ROOT/cache

source $RBENV_ROOT/completions/rbenv.zsh
command rbenv rehash 2>/dev/null
rbenv() {
  local command
  command="$1"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  rehash|shell)
    eval "$(rbenv "sh-$command" "$@")";;
  *)
    command rbenv "$command" "$@";;
  esac
}

# nvm
export NVM_DIR="$HOME/.local/nvm"
source "$NVM_DIR/nvm.sh"
