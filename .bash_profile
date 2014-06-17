# Set architecture flags
export ARCHFLAGS="-arch x86_64"

# Ensure user-installed binaries take precedence
export PATH=~/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/heroku/bin:$PATH

# Load ~/.extra: can be used for other settings you don’t want to commit.
for file in ~/.{bash_prompt,extra}; do
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
function project_aware_subl {
    project_file=$(ls -a $USER.sublime-project 2>/dev/null | head -n 1)
    subl ${*:-${project_file:-.}}
}

function svndiff () {
  svn diff ${1+"$@"} | colordiff | less -R
}

alias e='project_aware_subl'
alias st='stree'

alias s='fab run'
alias swu='workon sendwithus && cd ~/development/sendwithus'