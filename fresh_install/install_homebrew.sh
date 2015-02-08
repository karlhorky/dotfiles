#!/usr/bin/env bash

main() {
  if [ $(cmd_exists "brew") -eq 1 ]; then
    info "Installing Homebrew..."
    printf "\n" | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    #  └─ simulate the ENTER keypress

    result $? "Homebrew"
  fi
}

main
