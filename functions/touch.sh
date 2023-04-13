#!/bin/bash

touch() {
  if [ "$1" = "-f" ]; then
    filePath=$(dirname "$2")
    mkdir -p "$filePath"
    command touch "${@:2}"
  else
    command touch "$@"
  fi
}