# don't put duplicate lines or lines starting with space in the history
HISTCONTROL=ignoreboth
# append to the history file, don't overwrite it
shopt -s histappend
HISTSIZE=10000
HISTFILESIZE=$HISTSIZE

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# enable color support
if [ -x /usr/bin/dircolors ]; then
    eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

## Aliases

alias ll="ls -l"
alias la="ls -lA"

# enable various auto-complete stuff

enable_posix_autocomplete() {
  if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
  fi
}

enable_osx_autocomplete() {
  if which brew &>/dev/null; then
    local brew_prefix=$(brew --prefix)
    if [ -f $brew_prefix/etc/bash_completion ]; then
      . $brew_prefix/etc/bash_completion
    fi
    for f in $brew_prefix/etc/bash_completion.d/*.sh \
      $brew_prefix/etc/bash_completion.d/*.bash; do
      . $f
    done
  fi
}

enable_posix_autocomplete
enable_osx_autocomplete

# make less more friendly for non-text input files
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
# Don't clear screen after quitting `man'
export MANPAGER="less -X"

export EDITOR=emacs

set_prompt() {
  local bold="\[$(tput bold)\]"
  local reset="\[$(tput sgr0)\]"
  local green="\[$(tput setaf 2)\]"
  local working_directory="\w"

  PS1="${reset}\n${working_directory}"

  if [[ $(type -t __git_ps1) == "function" ]]; then
    local git_branch_name='$(__git_ps1 " (%s)")'
    PS1+="${green}${git_branch_name}${reset}"
  fi

  # Highlight input (command)
  PS1+=" › ${bold}"

  # Hack to reset styles before displaying output, per
  # http://chakra.sourceforge.net/wiki/index.php/Color_Bash_Prompt
  trap 'echo -ne "$(tput sgr0)" >$(tty)' DEBUG
}

PROMPT_COMMAND='set_prompt'

# Include any environment-specific settings
if [[ -r ~/.profile ]]; then
    source ~/.profile
fi
