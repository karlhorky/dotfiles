#!/usr/bin/env bash

main() {
  # XCode Command Line Tools
  if [ $(xcode-select -p &> /dev/null; printf $?) -ne 0 ]; then
    info "Installing XCode Command Line Tools..."

    xcode-select --install &> /dev/null

    # Wait until the XCode Command Line Tools are installed
    while [ $(xcode-select -p &> /dev/null; printf $?) -ne 0 ]; do
      sleep 5
    done

    success "XCode Command Line Tools Installed\n"
  fi
}

main
