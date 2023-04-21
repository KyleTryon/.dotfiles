#!/bin/bash
# An additional option to the 'touch' command that automatically creates the parent directory for the file if it doesn't exist
# Usage: touch -f <file_path>

touch() {
  if [ "$1" = "-f" ]; then
    filePath=$(dirname "$2")
    mkdir -p "$filePath"
    command touch "${@:2}"
  else
    command touch "$@"
  fi
}