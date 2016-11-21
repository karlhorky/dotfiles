# Set architecture flags
export ARCHFLAGS="-arch x86_64"

# Set Go path
export GOPATH=$HOME/go

# Ensure GNU core utilities and user-installed binaries take precedence
export PATH=/usr/local/opt/coreutils/libexec/gnubin:~/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/usr/local/sbin:~/.composer/vendor/bin:/usr/local/Cellar/docker-machine/0.5.0-rc3/bin:$GOPATH/bin:$PATH

export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH

# Load ~/.local for other settings you don’t want to commit.
for file in ~/.{bash_prompt,colors,local}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

export EDITOR='vim'

# Load a user's project when `subl` called without arguments
# Name your project file <username>.sublime-project
function subl {
  project_file=$(\ls -a $(basename `pwd`)-$USER.sublime-project 2>/dev/null | head -n 1)
  "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" ${*:-${project_file:-.}}
}

cmd_exists() {
  [ -x "$(command -v "$1")" ] \
    && printf 0 \
    || printf 1
}

# Add SSH keys for ssh-agent
# https://www.reddit.com/r/osx/comments/52zn5r/difficulties_with_sshagent_in_macos_sierra/
/usr/bin/ssh-add -A &> /dev/null
