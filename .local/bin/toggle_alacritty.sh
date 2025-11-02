#!/bin/bash

# Find the window ID for Alacritty
WID=$(xdotool search --class Alacritty | head -n 1)

if [ -z "$WID" ]; then
  # If not running, start Alacritty
  $HOME/.cargo/bin/alacritty &
else
  # If running, check if it's the active window
  ACTIVE_WID=$(xdotool getactivewindow)
  if [ "$WID" = "$ACTIVE_WID" ]; then
    # If it is the active window, minimize it
    xdotool windowminimize "$WID"
  else
    # If not the active window, bring it to the front
    xdotool windowactivate "$WID"
  fi
fi
