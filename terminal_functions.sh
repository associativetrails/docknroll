#!/bin/bash

# To include this file: source ~/Dev/bash/terminal_functions.sh

# Open terminal window
# To call function: open_terminal_window "commands_to_run" "theme" "columns" "rows"
# e.g. open_terminal_window "cd ~/Dev/django/sling && sleep 5 && docker-compose exec web ./manage.py test" "Grass" 120 60
open_terminal_window() {
  commands_to_run="$1"  # Commands to run in the new terminal window
  theme="${2:-Homebrew}"  # Use second argument, or 'Homebrew' if not provided
  columns="${3:-120}"  # Use third argument, or '120' if not provided
  rows="${4:-60}"  # Use fourth argument, or '60' if not provided

  osascript -e "tell application \"Terminal\"" \
            -e "activate" \
            -e "set newWindow to do script \"$commands_to_run\"" \
            -e "set current settings of front window to settings set \"$theme\"" \
            -e "delay 0.2" \
            -e "set number of columns of front window to $columns" \
            -e "set number of rows of front window to $rows" \
            -e "end tell"
}

# Use special blue theme
open_live_terminal_window() {
  commands_to_run="$1"  # Commands to run in the new terminal window
  open_terminal_window "$1" "Live Server Connection" 120 60
}


# Use green theme
open_local_testing_terminal_window() {
  commands_to_run="$1"  # Commands to run in the new terminal window
  open_terminal_window "$1" Grass 120 60
}