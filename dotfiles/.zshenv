export EDITOR=emacsclient
export ALTERNATE_EDITOR='emacs -nw'

if [[ "$(/usr/bin/uname -m)" == arm64 ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  eval "$(/usr/local/bin/brew shellenv)"
fi

if [[ -r ~/src/remix-utils/zshenv ]]; then
  source ~/src/remix-utils/zshenv
fi
