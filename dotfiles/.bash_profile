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

# Serve a directory over HTTP
alias servedir="python -m SimpleHTTPServer 1234"

# View HTTP traffic
#alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
#alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

# enable various auto-complete stuff
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  . /etc/bash_completion
fi

if [ -d /usr/local/etc/bash_completion.d ]; then
  for f in /usr/local/etc/bash_completion.d/*; do
    source $f
  done
fi

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

  PS1="\n${bold}${working_directory}${reset}"

  if [[ $(type -t __git_ps1) == "function" ]]; then
    local git_branch_name='$(__git_ps1 " (%s)")'
    PS1+="${green}${git_branch_name}${reset}"
  fi

  # Highlight input (command)
  PS1+=" $ ${bold}"

  # Hack to reset styles before displaying output, per
  # http://chakra.sourceforge.net/wiki/index.php/Color_Bash_Prompt
  trap 'echo -ne "$(tput sgr0)" >$(tty)' DEBUG
}

PROMPT_COMMAND='set_prompt'

# Include any environment-specific settings
if [[ -r ~/.profile ]]; then
    source ~/.profile
fi
