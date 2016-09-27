#!/bin/bash
SESSION='cfme-performance'

tmux -2 new-session -d -s $SESSION -n 'cfme-performance'

# Setup a window and split panes, source venv, tail log file
tmux new-window -t $SESSION:1 -n 'cp01'
tmux send-keys "cd /root/cfme-performance-01;. bin/activate;cd cfme-performance" C-m
tmux split-window -v
tmux select-pane -t 1
tmux send-keys "cd /root/cfme-performance-01;. bin/activate;cd cfme-performance/cfme-performance/log" C-m
tmux send-keys "tailf cfme-performance.log" C-m
tmux select-pane -t 0

tmux new-window -t $SESSION:2 -n 'cp02'
tmux send-keys "cd /root/cfme-performance-02;. bin/activate;cd cfme-performance" C-m
tmux split-window -v
tmux select-pane -t 1
tmux send-keys "cd /root/cfme-performance-02;. bin/activate;cd cfme-performance/cfme-performance/log" C-m
tmux send-keys "tailf cfme-performance.log" C-m
tmux select-pane -t 0

tmux new-window -t $SESSION:3 -n 'cp03'
tmux send-keys "cd /root/cfme-performance-03;. bin/activate;cd cfme-performance" C-m
tmux split-window -v
tmux select-pane -t 1
tmux send-keys "cd /root/cfme-performance-03;. bin/activate;cd cfme-performance/cfme-performance/log" C-m
tmux send-keys "tailf cfme-performance.log" C-m
tmux select-pane -t 0


tmux select-window -t $SESSION:1

tmux -2 attach-session -t $SESSION

