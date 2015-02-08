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
    "coreutils"
    "moreutils"
    "findutils"
    "gnu-sed --with-default-names"
    "bash"
    "bash-completion"
    "homebrew/dupes/grep"
    "homebrew/dupes/openssh"

    "vim --override-system-vi"
    "git"
    "hub"

    "node"
    "caskroom/cask/brew-cask"
  )

  execute "brew update" "brew update"
  execute "brew upgrade" "brew upgrade"
  execute "brew cleanup" "brew cleanup"

  for i in ${!formulae[*]}; do
    formula="${formulae[$i]}"
    [ $(brew list "$formula" &> /dev/null; printf $?) -eq 0 ] \
      && success "$formula" \
      || execute "brew install $formula" "brew install $formula"
  done

  success "Homebrew formulae installed!"
}

main
