# Set architecture flags
export ARCHFLAGS="-arch x86_64"

# Ensure GNU core utilities and user-installed binaries take precedence
export PATH=/usr/local/opt/coreutils/libexec/gnubin:~/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/usr/local/sbin:$PATH

export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH

# Load ~/.local for other settings you don’t want to commit.
for file in ~/.{bash_prompt,colors,local}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

export EDITOR='vim'

# Load .bashrc if it exists
test -f ~/.bashrc && source ~/.bashrc

# Add tab completion for many Bash commands
if which brew > /dev/null && [ -f "$(brew --prefix)/etc/bash_completion" ]; then
  source "$(brew --prefix)/etc/bash_completion";
elif [ -f /etc/bash_completion ]; then
  source /etc/bash_completion;
fi;

# Name your file <username>.sublime-project
function subl {
  project_file=$(\ls -a $USER.sublime-project 2>/dev/null | head -n 1)
  "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" ${*:-${project_file:-.}}
}

# Always use color output for `ls`
alias ls="command ls --color"
alias ll="ls -laF --color"