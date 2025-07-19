#!/usr/bin/env bash




if [[ $# -eq 1 ]]; then
    server=$1
else
    server=$(grep -E '^Host ' ~/.ssh/config | awk '{print $2}' | fzf)
fi

if [[ -z $server ]]; then
    echo "Connection Failed: Unknown Hostname"
    exit 0
fi

echo "Connecting to $server..."

# tmux_running=$(pgrep tmux)

tmux has-session -t $server &> /dev/null
if [ $? != 0 ]; then
    tmux new-session -d -s $server ssh $server
fi
tmux attach -t $server

# if [tmux has-session -t $server ]; then
#     echo test
#     tmux new-session -s $server; tmux attatch -t $server
#     exit 0
# fi



