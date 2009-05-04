#!/usr/bin/env zsh
# /etc/zsh/zshrc
# Global zsh configuration
#    _________  _   _ ____   ____ 
#   |__  / ___|| | | |  _ \ / ___|
#     / /\___ \| |_| | |_) | |    
#    / /_ ___) |  _  |  _ <| |___ 
#   /____|____/|_| |_|_| \_\\____|
#                                 
# philpep zshrc
# http://philpep.org
# Thanks to Geekounet http://poildetroll.net

# {{{ Variables d environnement

export EDITOR=vim
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
export GREP_COLOR=31
export PAGER="col -b | vim -c 'set ft=man nomod nolist' -"

# }}}

# {{{ Configuration générale

HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000
setopt append_history hist_ignore_all_dups hist_reduce_blanks
setopt autocd
unsetopt beep
unsetopt notify
setopt extendedglob

autoload -U colors
colors

watch=all

# }}}

# {{{ Completion diverses et variées

autoload -Uz compinit
compinit
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh_cache
zmodload zsh/complist
zstyle ':completion:*:processes' command 'ps -aU$USER'
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"

# }}}

# {{{ Somes aliases

case `uname -s` in
  FreeBSD)
  export LSCOLORS="exgxfxcxcxdxdxhbadacec"
  alias ls="ls -G"
  alias ll="ls -Glh"
  alias lla="ls -Glha"
  alias lll="ls -Glh | less"
  alias grep="grep --colour"
  ;;
  Linux)
  if [[ -r ~/.dir_colors ]]; then
    eval `dircolors -b ~/.dir_colors`
  elif [[ -r /etc/DIR_COLORS ]]; then
    eval `dircolors -b /etc/DIR_COLORS`
  fi
  alias ls="ls --color=auto"
  alias ll='ls --color=auto -lh'
  alias lla='ls --color=auto -lha'
  alias lll='ls --color=auto -lh | less'
  alias grep='grep --color=auto'
  ;;
esac

zstyle ':completion:*' list-colors ${(s.:.)LSCOLORS}

alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -v'
alias xs='cd'
alias sl='ls'
alias :e="\$EDITOR"
alias :wq='exit'
alias :q!='exit'
alias less='less -r'
alias more='less -r'
alias c='clear'
alias exit="clear; exit"
# Extra alias
alias bashfr="lynx --dump --display_charset=utf8 \"http://www.bashfr.org/?sort=random2\" | awk '\$1~\"#\" && \$0!~\"RSS\" { getline; while (\$1!~\"#\") { print \$0; getline;}; exit}'"
alias 2html='vim -e +:zR +:TOhtml +w +qa'
alias top-10="sed -e 's/sudo //' $HOME/.histfile |  cut -d' ' -f1 | sort | uniq -c | sort -rg | head"


# }}}

# {{{ Fonctions et autres trucs


# Convert * to mp3 files
function 2mp3() 
{
  until [ -z $1 ]
  do
    ffmpeg -i $1 -acodec libmp3lame "`basename $1`.mp3"
    shift
  done
}


function title
{
  t="%n@%M %~"

  case $TERM in
    screen|screen.linux)
    print -nP "\ek$t\e\\"
    print -nP "\e]0;$t\a"
    ;;
    xterm*|rxvt*|(E|e)term)
    print -nP "\e]0;$t\a"
    ;;
  esac
}

function precmd
{
  title

  local deco="%{${fg_bold[black]}%}"

  if [[ -O "$PWD" ]]; then
    local path_color="${fg_no_bold[white]}"
  elif [[ -w "$PWD" ]]; then
    local path_color="${fg_no_bold[blue]}"
  else
    local path_color="${fg_no_bold[red]}"
  fi

  case ${HOST%%.*} in
    squat) local host_color="${fg_bold[green]}" ;;
    shen)  local host_color="${fg_bold[blue]}" ;;
    *)     local host_color="${fg_bold[default]}" ;;
  esac

  local yellow="%{${fg_bold[yellow]}%}"

  local return_code="%(?..${deco}!%{${fg_no_bold[red]}%}%?${deco}! )"
  local user_at_host="%{${fg_bold[red]}%}%n${yellow}@%{${host_color}%}%M"
  local cwd="%{${path_color}%}%48<...<%~"
  local sign="%(!.%{${fg_bold[red]}%}.${deco})%#"

  PS1="${return_code}${deco}(${user_at_host} ${cwd}${deco}) ${sign}%{${reset_color}%} "
}

# }}}

# vim:filetype=zsh:tabstop=8:shiftwidth=2:fdm=marker: