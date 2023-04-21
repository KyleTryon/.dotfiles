#!/bin/bash
# An alternative to the 'git clone' command that automatically changes directory to the newly cloned repo
# Usage: clone <repo_url>

clone() {
  local url="$1"

  if [[ -z "$url" ]]; then
    echo "No repo specified"
    return 1
  fi

  git clone "${url}"
  repo=${url##*/}
  echo "Cloned ${repo}"
  dir="${repo%.*}"
  echo "Changing directory to ${dir}"
  cd "${dir}" || return
}
