#!/usr/bin/env bash

source "utils.sh"

main() {
  info "Changing shell to newest zsh installed by Homebrew..."

  # Change to new zsh installed by Homebrew
  local zsh_path=$(brew --prefix)/bin/zsh

  if grep -q "$zsh_path" /etc/shells; then
    sudo echo $zsh_path >> /etc/shells
  fi

  # Set for current user only
  sudo -u $SUDO_USER chsh -s "$zsh_path"
  success "Upgraded to zsh $ZSH_VERSION!"
}

main
