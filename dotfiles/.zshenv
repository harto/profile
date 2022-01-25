export EDITOR=emacsclient
export ALTERNATE_EDITOR='emacs -nw'
export PATH=$HOME/bin:$PATH

if [[ "$(/usr/bin/uname -m)" == arm64 ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  eval "$(/usr/local/bin/brew shellenv)"
fi

source ~/remix/zshenv
