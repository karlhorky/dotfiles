#!/usr/bin/env bash

main() {
  # Change to new Bash installed by Homebrew
  local bash_path=$(brew --prefix)/bin/bash
  sudo echo "$bash_path" >> /etc/shells

  # Set for current user only
  chsh -s $BASHPATH
  success "Upgraded to Bash $BASH_VERSION!"
}

main
