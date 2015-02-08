#!/usr/bin/env bash

success() {
  printf "\e[0;32m✔ $1\e[0m\n"
}

error() {
  printf "\e[0;31m✖ $1 $2\e[0m\n"
}

info() {
  printf "\n\e[0;35m $1\e[0m\n\n"
}

question() {
  printf "\e[0;33m? $1\e[0m"
}

result() {
  [ $1 -eq 0 ] \
    && success "$2" \
    || error "$2"

  [ "$3" == "true" ] && [ $1 -ne 0 ] \
      && exit
}

ask() {
  question "$1 "
  read
}

confirm() {
  question "$1 (y/n) "
  read -n 1
  printf "\n"
}

said_yes() {
  [[ "$REPLY" =~ ^[Yy]$ ]] \
    && return 0 \
    || return 1
}


execute() {
  $1 &> /dev/null
  result $? "${2:-$1}"
}


ask_for_sudo() {
  # Ask for the administrator password
  sudo -v

  # Update existing `sudo` time stamp until this script has finished
  # https://gist.github.com/cowboy/3118588
  while true; do
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
  done &> /dev/null &
}


# Test whether a command exists
# $1 - cmd to test
cmd_exists() {
  [ -x "$(command -v "$1")" ] \
    && printf 0 \
    || printf 1
}

# Test whether a Homebrew formula is already installed
# $1 - formula name (may include options)
formula_exists() {
    if $(brew list $1 >/dev/null); then
        printf "%s already installed.\n" "$1"
        return 0
    fi

    e_warning "Missing formula: $1"
    return 1
}
