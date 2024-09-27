#!/usr/bin/env zsh
# Check if a symlink path is provided

# Get the target of the symlink
symlink_target=$(readlink ~/documents/university/current_course)

# Check if the symlink is valid and exists
if [ -z "$symlink_target" ]; then
  echo "Error: is not a valid symlink or does not exist."
  exit 1
fi

directory_name=$(basename "$symlink_target")

# Output the target of the symlink
echo "$directory_name"

pkill -RTMIN+10 waybar  # Emit the signal (adjust number based on your config)

