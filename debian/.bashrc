# System-wide .bashrc file for interactive bash(1) shells.

# To enable the settings / commands in this file for login shells as well,
# this file has to be sourced in /etc/profile.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

use_color=false

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
        && type -P dircolors >/dev/null \
        && match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
        # Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
        if type -P dircolors >/dev/null ; then
                if [[ -f ~/.dir_colors ]] ; then
                        eval $(dircolors -b ~/.dir_colors)
                elif [[ -f /etc/DIR_COLORS ]] ; then
                        eval $(dircolors -b /etc/DIR_COLORS)
                fi
        fi

        if [[ ${EUID} == 0 ]] ; then
                PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[00m\] '
        else
                if git --version &>/dev/null; then
        		# PS1 Line to show current Git Branch in the Prompt
        		PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[01;32m\]$(__git_ps1 " (%s)")\[\033[00m\]\$ '
    		else
        		# Original PS1 Line
        		PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    		fi
        fi

        alias ls='ls --color=auto'
        alias grep='grep --colour=auto'
else
        if [[ ${EUID} == 0 ]] ; then
                # show root@ when we don't have colors
                PS1='\u@\h \W \$ '
        else
                PS1='\u@\h \w \$ '
        fi
fi

# Try to keep environment pollution down, EPA loves us.
unset use_color safe_term match_lhs

# Commented out, don't overwrite xterm -T "title" -n "icontitle" by default.
# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
#    ;;
#*)
#    ;;
#esac

# enable bash completion in interactive shells
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# if the command-not-found package is installed, use it
if [ -x /usr/lib/command-not-found -o -x /usr/share/command-not-found ]; then
	function command_not_found_handle {
	        # check because c-n-f could've been removed in the meantime
                if [ -x /usr/lib/command-not-found ]; then
		   /usr/bin/python /usr/lib/command-not-found -- $1
                   return $?
                elif [ -x /usr/share/command-not-found ]; then
		   /usr/bin/python /usr/share/command-not-found -- $1
                   return $?
		else
		   return 127
		fi
	}
fi

#
# ~/.bashrc
#

# Display unstaged (*) and staged(+) changes
export GIT_PS1_SHOWDIRTYSTATE="1"

# Display whether there are stashed ($) changes
export GIT_PS1_SHOWSTASHSTATE="1"

# Display if there are untracked (%) files
export GIT_PS1_SHOWUNTRACKEDFILES="1"

# Explicitly unset color (default anyhow). Use 1 to set it.
export GIT_PS1_SHOWCOLORHINTS=true

# Display if we're ahead (>) or behind (<) or diverged (<>) relative to upstream
export GIT_PS1_SHOWUPSTREAM="auto verbose git"

# If you would like to see more information about the identity of
# commits checked out as a detached HEAD, set GIT_PS1_DESCRIBE_STYLE
# to one of these values:
#
#     contains      relative to newer annotated tag (v1.6.3.2~35)
#     branch        relative to newer tag or branch (master~4)
#     describe      relative to older annotated tag (v1.6.3.1-13-gdd42c2f)
#     default       exactly matching tag
export GIT_PS1_DESCRIBE_STYLE="branch"

# http://unix.stackexchange.com/questions/119/colors-in-man-pages
# Get color support for 'less'
export LESS="--RAW-CONTROL-CHARS"

# Use colors for less, man, etc.
[[ -f ~/.LESS_TERMCAP ]] && . ~/.LESS_TERMCAP

# https://wiki.archlinux.org/index.php/Man_Page
# man() {
#     env LESS_TERMCAP_mb=$'\E[01;31m' \
# 	LESS_TERMCAP_md=$'\E[01;38;5;74m' \
# 	LESS_TERMCAP_me=$'\E[0m' \
# 	LESS_TERMCAP_se=$'\E[0m' \
# 	LESS_TERMCAP_so=$'\E[38;5;246m' \
# 	LESS_TERMCAP_ue=$'\E[0m' \
# 	LESS_TERMCAP_us=$'\E[04;38;5;146m' \
# 	man "$@"
# }

# PROMPT_COMMAND='__git_ps1 "\u \W" "\\\$ " "{%s $(get_ssh)}"'
# DEFAULT_COLOR='\[\e[0m\]'
# BLACK='\[\e[0;30m\]'
# LTBLUE='\[\e[1;34m\]'
# LTRED='\[\e[1;31m\]'

# USER_COLOR=$LTBLUE
# GIT_CHANGE_COLOR=$LTRED
# GIT_NO_CHANGE_COLOR="$BLACK"

# gitPrompt() {
#   local gitPrompt=$(__git_ps1)
#   local gitColor="$GIT_NO_CHANGE_COLOR"
#   if [ -n "$gitPrompt" ]; then
#     branch=$(git symbolic-ref HEAD 2>/dev/null)
#     if [ "$gitPrompt" != " (${branch##refs/heads/})" ]; then
#       gitColor="$GIT_CHANGE_COLOR"
#     fi
#   fi
#   echo "$USER_COLOR\u@\h:\W$gitColor$gitPrompt$DEFAULT_COLOR$ "
# }

# PROMPT_COMMAND='PS1="$(gitPrompt)"'

# pik_info() {
#  version= pik info | awk '/full_version/ {print $2,$3}' | sed 's/\"//;s/\s/\-/'
#  printf "${version}"
# }

# function prompt {
#   local LIGHT_RED="\[\033[1;31m\]"
#   local LIGHT_GREEN="\[\033[1;32m\]"
#  local NO_COLOUR="\[\033[0m\]"
#
#  local TITLEBAR='\[\033]0;\u@\h\007\]'

#  export GIT_PS1_SHOWDIRTYSTATE=true
#  export GIT_PS1_SHOWUNTRACKEDFILES=true
  # export GIT_PS1_SHOWUPSTREAM=auto
#  export GIT_PS1_SHOWSTASHSTATE=true

#  PS1="$TITLEBAR\n\w/$LIGHT_GREEN\$(__git_ps1 ' (%s)')$LIGHT_RED \$(pik_info)\n$NO_COLOUR$ "
#}

# prompt

