# autoload -Uz compinit && compinit

# Make word deletion a little less aggressive
autoload -U select-word-style
select-word-style bash

PROMPT='%~ %# '

if [[ "$INSIDE_EMACS" = 'vterm' ]]; then
  source ~/.emacs.d/etc/vterm.zsh
fi

alias e=$EDITOR

if [[ -r ~/src/remix-setup/dotfiles/.zshrc ]]; then
  source ~/src/remix-setup/dotfiles/.zshrc
fi
