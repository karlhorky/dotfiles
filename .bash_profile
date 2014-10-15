# Set architecture flags
export ARCHFLAGS="-arch x86_64"

# Ensure user-installed binaries take precedence
export PATH=/usr/local/opt/coreutils/libexec/gnubin:~/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin:/usr/local/heroku/bin:$PATH

export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH

# Load ~/.extra: can be used for other settings you don’t want to commit.
for file in ~/.{bash_prompt,extra,python,colors}; do
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

# Alias Github's hub to git https://github.com/github/hub
eval "$(hub alias -s)"

# Name your file <username>.sublime-project
function project_aware_subl {
    project_file=$(ls -a $USER.sublime-project 2>/dev/null | head -n 1)
    subl ${*:-${project_file:-.}}
}

function svndiff () {
  svn diff ${1+"$@"} | colordiff | less -R
}

# Load chruby if it exists
test -f /usr/local/share/chruby/chruby.sh && source /usr/local/share/chruby/chruby.sh
test -f /usr/local/share/chruby/auto.sh && source /usr/local/share/chruby/auto.sh

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
  colorflag="--color"
else # OS X `ls`
  colorflag="-G"
fi

alias ll="ls -laF ${colorflag}"

# Always use color output for `ls`
alias ls="command ls ${colorflag}"

alias e='project_aware_subl'
alias st='stree'

alias s='fab run'
alias swu='workon sendwithus && cd ~/projects/sendwithus'
