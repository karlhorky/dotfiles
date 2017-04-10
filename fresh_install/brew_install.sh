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
  execute "brew cask install slack" "brew cask install slack"
  execute "brew cask install steelseries-exactmouse-tool" "brew cask install steelseries-exactmouse-tool"
  execute "brew cask install magicprefs" "brew cask install magicprefs"
  execute "brew cask install yujitach-menumeters" "brew cask install yujitach-menumeters"
  execute "brew cask install flycut" "brew cask install flycut"

  # Install Atom and packages
  execute "brew cask install atom" "brew cask install atom"
  execute "apm install atom-alignment" "apm install atom-alignment"
  execute "apm install busy-signal" "apm install busy-signal"
  execute "apm install easy-motion-redux" "apm install easy-motion-redux"
  execute "apm install editorconfig" "apm install editorconfig"
  execute "apm install highlight-line" "apm install highlight-line"
  execute "apm install intentions" "apm install intentions"
  execute "apm install language-groovy" "apm install language-groovy"
  execute "apm install language-reason" "apm install language-reason"
  execute "apm install linter" "apm install linter"
  execute "apm install linter-flow" "apm install linter-flow"
  execute "apm install linter-ui-default" "apm install linter-ui-default"
  execute "apm install n-panes" "apm install n-panes"
  execute "apm install prettier-atom" "apm install prettier-atom"
  execute "apm install save-session" "apm install save-session"
  execute "apm install vim-mode-plus" "apm install vim-mode-plus"

  # Install Mac App Store software
  execute "brew install mas" "brew install mas"
  execute "mas install 1176895641" "mas install 1176895641" # Spark - Love your email again

  success "Homebrew formulae installed!"
}

main
