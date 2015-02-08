#!/usr/bin/env bash

main() {
  local name=""
  local email=""

  info "Creating private user files..."

  ask "What is your full name (for git)?"
  name="$REPLY"

  ask "What is your email address (for git)?"
  email="$REPLY"

  echo "[user]
  name = $name
  email = $email" > "$HOME/.gitconfig.user"
}

main
