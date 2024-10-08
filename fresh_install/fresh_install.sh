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

ask_for_sudo

source "fresh_install/symlink_settings.sh"
source "fresh_install/write_user_files.sh"
source "fresh_install/macos.sh"
source "fresh_install/command_line_tools.sh"
source "fresh_install/install_homebrew.sh"
source "fresh_install/fix_permissions.sh"
source "fresh_install/brew_install.sh"
source "fresh_install/custom_scripts.sh"
sudo bash "fresh_install/change_zsh.sh"
