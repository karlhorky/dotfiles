#!/usr/bin/env bash

declare -r DOTFILES="$(cd $(dirname "${BASH_SOURCE}")/../ && pwd -P)"

cd "$DOTFILES"
source "utils.sh"
confirm "Setting up a new system. This will:

  -symlink settings files to the home directory
  -configure OS X system settings
  -install all Homebrew software

Continue?"

if ! said_yes; then exit 1; fi

source "fresh_install/symlink_settings.sh"
source "fresh_install/osx.sh"
# source ./homebrew.sh
# source ./fix_permissions.sh
# source ./brew_install.sh
# source ./cask_install.sh
# source "$HOME/.bash_profile"
