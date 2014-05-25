#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE}")"
git pull origin master
function setup() {
	rsync --exclude ".git/" --exclude ".DS_Store" --exclude "setup.sh" \
		--exclude "README.md"  -avh --no-perms . ~
	source ~/.bash_profile
}
if [ "$1" == "--force" -o "$1" == "-f" ]; then
	setup
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		setup
	fi
fi
unset setup