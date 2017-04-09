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
    "vim"
    "git"
    "hub"
    "node"
    "yarn"
  )

  for i in ${!formulae[*]}; do
    formula="${formulae[$i]}"
    [ $(brew list "$formula" &> /dev/null; printf $?) -eq 0 ] \
      && success "$formula" \
      || execute "brew install $formula" "brew install $formula"
  done
  
  execute "brew cask install google-chrome" "brew cask install google-chrome"
  execute "brew cask install hyper" "brew cask install hyper"
  execute "brew cask install atom" "brew cask install atom"
  execute "brew cask install slack" "brew cask install slack"
  execute "brew cask install steelseries-exactmouse-tool" "brew cask install steelseries-exactmouse-tool"
  execute "brew cask install magicprefs" "brew cask install magicprefs"
  execute "brew cask install flycut" "brew cask install flycut"

  # Install Mac App Store software
  execute "brew install mas" "brew install mas"
  execute "mas install 1176895641" "mas install 1176895641" # Spark - Love your email again

  success "Homebrew formulae installed!"
}

main
