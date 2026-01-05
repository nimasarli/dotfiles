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

# create dir and enter
# example: mkcd my_dir
mkcd () {
  mkdir "$1"
  cd "$1"
}

# tmux
alias tmux_2='tmux new-session\; split-window -h\; selectp -L'
alias tmux_4='tmux new-session\; split-window -h\; split-window -v\; selectp -L\; split-window -v\; selectp -U'

# git
alias git_aliases='git config -l | grep alias | sed 's/^alias\.//g''
alias git_clean_mess='git rm --cached -r .; git reset --hard'
alias gcdev='git checkout develop'

# chmod
alias make_editable='sudo chmod -R 777 ./'

# editing/openning my_aliases file
alias edit_bashrc='sudo gedit ~/.my_aliases.sh'
alias open_bashrc='gedit ~/.my_aliases.sh'

# Carla Simulator
# activate carla venv before running aliases
alias run_carla='cd ~/NS_ROOT/introduction_to_self_driving_cars/material/project/CarlaSimulator; ./CarlaUE4.sh /Game/Maps/RaceTrack -windowed -carla-server -benchmark -fps=30; cd -'

# Convert video to gif file.
# Usage: video2gif video_file (scale) (fps) (e.g. "video2gif input.flv 1000 25" scales to 1000 width with 25 frames per second.)
video2gif() {
  ffmpeg -y -i "${1}" -vf fps=${3:-10},scale=${2:-320}:-1:flags=lanczos,palettegen "${1}.png"
  ffmpeg -i "${1}" -i "${1}.png" -filter_complex "fps=${3:-10},scale=${2:-320}:-1:flags=lanczos[x];[x][1:v]paletteuse" "${1}".gif
  rm "${1}.png"
}

# ROS
source /opt/ros/noetic/setup.bash

# Compile a single file with g++
# example: gpp_build tree_height.cpp output
gpp_build () {
# complete form:
# g++ -Wall -pipe -O2 -std=c++14 -o tree-height tree-height.cpp  
  g++ -Wall -O2 -o "$2" "$1"
}

# Build iplatform software
# Linux Release
blinux() {
    pushd .
    cd ~/src/iplatform/devops/build_iplatform_app/src
    python3 build_iplatform.py linux_release all "$@"
    popd
}
