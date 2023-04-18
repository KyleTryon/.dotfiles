#!/bin/bash
clone() {
  local url="$1"

  if [[ -z "$repo" ]]; then
    echo "No repo specified"
    return 1
  fi

  git clone "${url}"
  repo=${url##*/}
  dir="${//\.git//}"
  cd "${dir}" || return
}