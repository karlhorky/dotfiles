#!/usr/bin/env bash
if ! [ -d "/usr/local/.git" ] || ! [ "$(find /usr/local/.git -type d -empty >/dev/null)" ]; then
  info "Installing Homebrew..."
  printf "\n" | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  #  └─ simulate the ENTER keypress

  print_result $? "brew"
fi
