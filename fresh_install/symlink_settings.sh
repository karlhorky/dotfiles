#!/usr/bin/env bash

main() {
  info "Symlinking settings files..."

  local settings_path="$DOTFILES/settings/"

  local file=""
  local linkFile=""
  local filePath=""

  find $DOTFILES/settings -mindepth 1 -depth -type f | while read file; do

    linkFile="$(printf "%s" "$file" | sed "s|$settings_path||g")"

    # Create the directory if a directory path is involved
    if [[ $linkFile == *"/"* ]]; then
      filePath="$(printf "%s" "$linkFile" | sed "s|/[^/]*$|/|g")"

      if [ ! -d "$HOME/$filePath" ]; then
        echo "$HOME/$filePath"
        mkdir -p "$HOME/$filePath"
      fi
    fi


    linkFile="$HOME/$linkFile"

    if [ -e "$linkFile" ]; then
      if [ "$(readlink "$linkFile")" != "$file" ]; then
        confirm "'$linkFile' already exists, do you want to overwrite it?"

        if said_yes; then
          rm -rf "$linkFile"
          ln -fs $file $linkFile
          success "$linkFile → $file"
        else
          error "$linkFile → $file"
        fi

      else
        success "$linkFile → $file"
      fi

    else

	    	ln -fs "$file" "$linkFile"
        success "$linkFile → $file"
    fi
  done
}

main
