#!/usr/bin/env bash

main() {
  info "Fixing permissions..."

  local -a admin_directories=(
    "/Library/Caches/Homebrew" # Homebrew
    "/usr/local"               # Homebrew
  )

  for dir in ${admin_directories[@]}; do
    if [ -d "$dir" ]; then
      sudo chgrp -R admin "$dir"
      sudo chmod -R g+w "$dir"
    fi
  done

  success "Done fixing permissions!"
}

main
