# Don't autoload global init files (/etc/zprofile, /etc/zshrc, etc.)
unsetopt GLOBAL_RCS

if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

export HOMEBREW_NO_AUTO_UPDATE=1

path=(
  $HOME/bin
  $HOME/.local/bin
  # NOTE: When launching vterm from Emacs, PATH already includes everything
  # defined here. We filter out duplicates at the end of this file.
  $path
  /usr/local/bin
  /usr/bin
  /bin
  /usr/sbin
  /sbin
)
export PATH

export EDITOR=$HOME/.emacs.d/bin/emacsclient-wrapper

if [[ -r ~/src/remix-setup/dotfiles/.zshenv ]]; then
  source ~/src/remix-setup/dotfiles/.zshenv
fi

typeset -U path PATH
