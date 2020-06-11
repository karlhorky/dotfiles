#!/usr/bin/env bash

main() {
  local script_path=/usr/local/trash-downloads-screenshots-older-than-a-week.sh
  local script_content='find ~/Downloads -type f -mtime +7 -name "Screen Shot*" -exec mv {} ~/.Trash \;'
  echo "$script_content" > "$script_path"
  # This may fail if there's no crontab yet, you may need to create one with:
  # crontab -e
  crontab -u k -l | { cat; echo "0 10 * * * sh $script_path"; } | crontab -u k -
}

main