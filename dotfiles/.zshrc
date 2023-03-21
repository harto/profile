source ${HOMEBREW_PREFIX}/share/chruby/chruby.sh
source ${HOMEBREW_PREFIX}/share/chruby/auto.sh

eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# TODO: I think this belongs in .zshenv so that it works with non-login(?) /
# non-interactive(?) shells. But if I put it in .zshenv, something ends up
# putting /usr/bin near the start of the list, which means the stub java command
# gets run before the Homebrew-installed (openjdk) one.
path=(
  $HOME/bin
  $HOME/remix/bin
  $REMIX_HOME/bin
  ${HOMEBREW_PREFIX}/opt/openjdk/bin
  ${HOMEBREW_PREFIX}/bin
  $path
)
export PATH

# autoload -Uz compinit && compinit

PROMPT='%~ %# '

# vterm (https://github.com/akermu/emacs-libvterm) integration
if [[ "$INSIDE_EMACS" = 'vterm' ]]; then
  # https://github.com/akermu/emacs-libvterm#shell-side-configuration
  vterm_printf() {
    if [ -n "$TMUX" ] && ([ "${TERM%%-*}" = "tmux" ] || [ "${TERM%%-*}" = "screen" ]); then
      # Tell tmux to pass the escape sequences through
      printf "\ePtmux;\e\e]%s\007\e\\" "$1"
    elif [ "${TERM%%-*}" = "screen" ]; then
      # GNU screen (screen, screen-256color, screen-256color-bce)
      printf "\eP\e]%s\007\e\\" "$1"
    else
      printf "\e]%s\e\\" "$1"
    fi
  }

  # https://github.com/akermu/emacs-libvterm#vterm-clear-scrollback
  alias clear='vterm_printf "51;Evterm-clear-scrollback";tput clear'

  # https://github.com/akermu/emacs-libvterm#directory-tracking-and-prompt-tracking
  vterm_prompt_end() {
    vterm_printf "51;A$(whoami)@$(hostname):$(pwd)"
  }
  setopt PROMPT_SUBST
  PROMPT=$PROMPT'%{$(vterm_prompt_end)%}'
fi
