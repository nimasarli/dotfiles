# tmux
alias tmux_2='tmux new-session\; split-window -h\; selectp -L'
alias tmux_4='tmux new-session\; split-window -h\; split-window -v\; selectp -L\; split-window -v\; selectp -U'

# git
alias git_aliases='git config -l | grep alias | sed 's/^alias\.//g''
alias git_clean_mess='git rm --cached -r .; git reset --hard'
alias gcdev='git checkout develop'

# chmod
alias make_editable='sudo chmod -R 777 ./'

# Show the top 10 cpu using threads, sorted based on cpu usage
alias top_10='ps -eo pcpu,pid,user,args | tail -n +2 | sort -k1 -r -n | head -10'

# editing/openning my_aliases file
alias edit_bashrc='sudo gedit ~/.my_aliases.sh'
alias open_bashrc='gedit ~/.my_aliases.sh'
