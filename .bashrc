# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# compile a single file with g++
# example: gpp_build tree_height.cpp output
gpp_build () {
# complete form:
# g++ -Wall -pipe -O2 -std=c++14 -o tree-height tree-height.cpp  
  g++ -Wall -O2 -o "$2" "$1"
}

# Bash color mapping
grey='\[\033[1;30m\]'
red='\[\033[0;31m\]'
RED='\[\033[1;31m\]'
green='\[\033[0;32m\]'
GREEN='\[\033[1;32m\]'
yellow='\[\033[0;33m\]'
YELLOW='\[\033[1;33m\]'
purple='\[\033[0;35m\]'
PURPLE='\[\033[1;35m\]'
white='\[\033[0;37m\]'
WHITE='\[\033[1;37m\]'
blue='\[\033[0;34m\]'
BLUE='\[\033[1;34m\]'
cyan='\[\033[0;36m\]'
CYAN='\[\033[1;36m\]'
NC='\[\033[0m\]'

# Redefine PS1 variable to customize command prompt (See https://unix.stackexchange.com/questions/16120/in-bash-how-can-i-change-the-color-of-my-command-prompt)
PS1="$yellow[$CYAN\t$yellow][$red\H$yellow][$GREEN\w$grey$yellow]$NC# "

# git
alias git_aliases='git config -l | grep alias | sed 's/^alias\.//g''
alias git_clean_mess='git rm --cached -r .; git reset --hard'
alias gcdev='git checkout develop'

# chmod
alias make_editable='sudo chmod -R 777 ./'

# Show the top 10 cpu using threads, sorted based on cpu usage
alias top_10='ps -eo pcpu,pid,user,args | tail -n +2 | sort -k1 -r -n | head -10'

# editing/openning this file
alias edit_bashrc='sudo gedit ~/.bashrc'
alias open_bashrc='gedit ~/.bashrc'

# python
alias cd_robotic='cd ~/NS_ROOT/principles_of_robot_autonomy/AA274A_SECTIONS/'

source /opt/ros/noetic/setup.bash

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/nimasarli/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/nimasarli/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/nimasarli/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/nimasarli/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Pyenv initialize
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Carla Simulator
# activate carla venv before running aliases
alias run_carla='cd ~/NS_ROOT/introduction_to_self_driving_cars/material/project/CarlaSimulator; ./CarlaUE4.sh /Game/Maps/RaceTrack -windowed -carla-server -benchmark -fps=30; cd -'

# iPlatfrom
# everything
alias build_ipl_linux_all='cd ~/NS_ROOT/Dev/iplatform/devops/build_iplatform_app/src; /usr/bin/python3 build_iplatform.py linux_release all -T -P; cd -'
alias build_ipl_debug_linux_all='cd ~/NS_ROOT/Dev/iplatform/devops/build_iplatform_app/src; /usr/bin/python3 build_iplatform.py linux_debug all -T -P; cd -'
alias build_ipl_linux_all_c='cd ~/NS_ROOT/Dev/iplatform/devops/build_iplatform_app/src; /usr/bin/python3 build_iplatform.py linux_release all -C -T -P; cd -'
alias build_ipl_debug_linux_all_c='cd ~/NS_ROOT/Dev/iplatform/devops/build_iplatform_app/src; /usr/bin/python3 build_iplatform.py linux_debug all -C -T -P; cd -'
alias build_ipl_linux_all_t='cd ~/NS_ROOT/Dev/iplatform/devops/build_iplatform_app/src; /usr/bin/python3 build_iplatform.py linux_release all -P; cd -'
alias build_ipl_debug_linux_all_t='cd ~/NS_ROOT/Dev/iplatform/devops/build_iplatform_app/src; /usr/bin/python3 build_iplatform.py linux_debug all -P; cd -'
alias build_ipl_linux_all_t_c='cd ~/NS_ROOT/Dev/iplatform/devops/build_iplatform_app/src; /usr/bin/python3 build_iplatform.py linux_release all -C -P; cd -'
alias build_ipl_debug_linux_all_t_c='cd ~/NS_ROOT/Dev/iplatform/devops/build_iplatform_app/src; /usr/bin/python3 build_iplatform.py linux_debug all -C -P; cd -'
alias build_ipl_linux_all_p='cd ~/NS_ROOT/Dev/iplatform/devops/build_iplatform_app/src; /usr/bin/python3 build_iplatform.py linux_release all -T; cd -'
alias build_ipl_linux_debug_all_p='cd ~/NS_ROOT/Dev/iplatform/devops/build_iplatform_app/src; /usr/bin/python3 build_iplatform.py linux_debug all -T; cd -'
alias build_ipl_linux_debug_clean_all_p='cd ~/NS_ROOT/Dev/iplatform/devops/build_iplatform_app/src; /usr/bin/python3 build_iplatform.py linux_debug all --clean -T; cd -'
alias build_ipl_qnx7_all_p='cd ~/NS_ROOT/Dev/iplatform/devops/build_iplatform_app/src; /usr/bin/python3 build_iplatform.py qnx7_release all -T; cd -'
alias build_ipl_qnx7_all_t='cd ~/NS_ROOT/Dev/iplatform/devops/build_iplatform_app/src; /usr/bin/python3 build_iplatform.py qnx7_release all -P; cd -'
alias build_ipl_qnx7_all='cd ~/NS_ROOT/Dev/iplatform/devops/build_iplatform_app/src; /usr/bin/python3 build_iplatform.py qnx7_release all -T -P; cd -'
alias build_ipl_qnx7_debug_all='cd ~/NS_ROOT/Dev/iplatform/devops/build_iplatform_app/src; /usr/bin/python3 build_iplatform.py qnx7_debug all -T -P; cd -'
alias build_ipl_qnx7cc_debug_all_p='cd ~/NS_ROOT/Dev/iplatform/devops/build_iplatform_app/src; /usr/bin/python3 build_iplatform.py qnx7_cc_debug all -T; cd -'
alias build_ipl_qnx7cc_release_all_p='cd ~/NS_ROOT/Dev/iplatform/devops/build_iplatform_app/src; /usr/bin/python3 build_iplatform.py qnx7_cc_release all -T; cd -'
alias build_ipl_yocto_imx6_all='cd ~/NS_ROOT/Dev/iplatform/devops/build_iplatform_app/src; /usr/bin/python3 build_iplatform.py yocto_base all -T -P; cd -'
alias build_ipl_yocto_imx8_all_p='cd ~/NS_ROOT/Dev/iplatform/devops/build_iplatform_app/src; /usr/bin/python3 build_iplatform.py yocto_imx8 all -T; cd -'
alias build_ipl_qos_all='cd ~/NS_ROOT/Dev/iplatform/devops/build_iplatform_app/src; /usr/bin/python3 build_iplatform.py qos_release all -T -P; cd -'
alias build_ipl_qos_all_p='cd ~/NS_ROOT/Dev/iplatform/devops/build_iplatform_app/src; /usr/bin/python3 build_iplatform.py qos_release all -T; cd -'
alias build_ipl_qos_cc_all_p='cd ~/NS_ROOT/Dev/iplatform/devops/build_iplatform_app/src; /usr/bin/python3 build_iplatform.py qos_cc_release all -T; cd -'
alias build_ipl_qos_debug_all='cd ~/NS_ROOT/Dev/iplatform/devops/build_iplatform_app/src; /usr/bin/python3 build_iplatform.py qos_debug all -T -P; cd -'
alias build_ipl_qos_debug_all_p='cd ~/NS_ROOT/Dev/iplatform/devops/build_iplatform_app/src; /usr/bin/python3 build_iplatform.py qos_debug all -T; cd -'

# Convert video to gif file.
# Usage: video2gif video_file (scale) (fps) (e.g. "video2gif input.flv 1000 25" scales to 1000 width with 25 frames per second.)
video2gif() {
  ffmpeg -y -i "${1}" -vf fps=${3:-10},scale=${2:-320}:-1:flags=lanczos,palettegen "${1}.png"
  ffmpeg -i "${1}" -i "${1}.png" -filter_complex "fps=${3:-10},scale=${2:-320}:-1:flags=lanczos[x];[x][1:v]paletteuse" "${1}".gif
  rm "${1}.png"
}
