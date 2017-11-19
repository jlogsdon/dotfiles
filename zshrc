if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

export EDITOR=nvim
export VISUAL=nvim

alias vim=nvim
alias vimdiff="nvim -d"

path=(
  "./bin"
  "$HOME/bin"
  "/usr/local/bin"
  "/usr/local/sbin"
  "/usr/bin" 
  "/usr/sbin"
)
