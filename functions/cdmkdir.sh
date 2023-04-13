#!/bin/bash

cdmkdir() {
  mkdir -p "$@" && cd "${1:-${HOME}}" || return
}