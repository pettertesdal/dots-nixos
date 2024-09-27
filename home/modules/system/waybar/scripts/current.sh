#!/usr/bin/env zsh
# Check if a symlink path is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <symlink_path>"
  exit 1
fi

# Get the target of the symlink
symlink_target=$(readlink "$1")

# Check if the symlink is valid and exists
if [ -z "$symlink_target" ]; then
  echo "Error: '$1' is not a valid symlink or does not exist."
  exit 1
fi

directory_name=$(basename "$symlink_target")

# Output the target of the symlink
echo "$directory_name"

pkill -RTMIN+10 waybar  # Emit the signal (adjust number based on your config)

