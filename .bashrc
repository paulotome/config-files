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
