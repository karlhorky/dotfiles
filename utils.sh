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

confirm() {
  printf "\e[0;33m? $1 (y/n) \e[0m"
  read -n 1
  printf "\n"
}

said_yes() {
  [[ "$REPLY" =~ ^[Yy]$ ]] \
    && return 0 \
    || return 1
}
