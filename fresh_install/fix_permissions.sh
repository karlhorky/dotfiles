#!/usr/bin/env bash

main() {
  local -a admin_directories=(
    "/Library/Caches/Homebrew" # Homebrew
    "/usr/local"               # Homebrew
  )

  for dir in ${admin_directories[@]}; do
    if [ -d "$dir" ]; then
      chgrp -R admin "$dir"
      chmod -R g+w "$dir"
    fi
  done
}

main
