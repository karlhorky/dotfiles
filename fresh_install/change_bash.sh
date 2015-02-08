#!/usr/bin/env bash

source "utils.sh"

main() {
  info "Changing shell to newest Bash installed by Homebrew..."

  # Change to new Bash installed by Homebrew
  local bash_path=$(brew --prefix)/bin/bash

  if grep -q "$bash_path" /etc/shells; then
    sudo echo $bash_path >> /etc/shells
  fi

  # Set for current user only
  sudo -u $SUDO_USER chsh -s "$bash_path"
  success "Upgraded to Bash $BASH_VERSION!"
}

main
