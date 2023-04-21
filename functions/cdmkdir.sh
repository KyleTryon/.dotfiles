#!/bin/bash
# An alternative to the 'mkdir' command that automatically changes directory to the newly created directory
# Usage: cdmkdir <dir_name>

cdmkdir() {
  mkdir -p "$@" && cd "${1:-${HOME}}" || return
}