#!/usr/bin/env bash

main() {
  info "Installing Homebrew formulae..."

  if [[ $(cmd_exists "brew") -eq 1 ]]; then
    error "Homebrew not installed!"
    exit 1
  fi

  local i=""
  local formula=""
  local -a formulae=(
    "vim --override-system-vi"
    "git"
    "hub"
    "node"
  )

  for i in ${!formulae[*]}; do
    formula="${formulae[$i]}"
    [ $(brew list "$formula" &> /dev/null; printf $?) -eq 0 ] \
      && success "$formula" \
      || execute "brew install $formula" "brew install $formula"
  done
  
  execute "brew cask install google-chrome" "brew cask install google-chrome"
  execute "brew cask install atom" "brew cask install atom"
  execute "brew cask install slack" "brew cask install slack"
  execute "brew cask install steelseries-exactmouse-tool" "brew cask install steelseries-exactmouse-tool"
  execute "brew cask install magicprefs" "brew cask install magicprefs"

  success "Homebrew formulae installed!"
}

main
