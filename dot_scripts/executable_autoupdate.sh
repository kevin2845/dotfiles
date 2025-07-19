#!/usr/bin/env bash

# Define the session name
SESSION="update_session"

# Start a new tmux session that runs the update commands and exits
# tmux new-session -d -s "$SESSION" "brew update; brew upgrade; pip install --upgrade pip; tmux kill-session -t $SESSION"
tmux new-session -d -s "$SESSION" "~/.scripts/update.sh"

# Optionally, you can wait a bit and then attach to the session to see the output
# sleep 2
# tmux attach-session -t "$SESSION"

echo "Update commands are running in the tmux session '$SESSION'..."
tmux display-message "Update commands are running in the tmux session '$SESSION'..."

